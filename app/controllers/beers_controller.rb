class BeersController < ApplicationController
  
  protect_from_forgery
  respond_to :html, :json
  
  def index
    get_beers
    order_beers
    if @beers.empty?
      @beers = Beer.scoped
    end
    @beers = @beers.paginate(:page => params[:page], :per_page => 10)
  end
  
  def my_beers
    get_beers
    if !current_user.present?
      redirect_to beers_path
    else
      params[:sort] ||= "rate"
      params[:direction] ||= "asc"
      brs = []
      get_ratings.each do |id|
        b = @beers.find_by_id(id)
        brs << b unless b.nil?
      end
      brs = %[abv_int ibu_int average_rating].include?(sort_column) && sort_direction == "asc" ? 
                  brs.sort_by{|b| -b[sort_column]} : 
                  brs.sort_by{|b| b[sort_column]}
      brs = brs.sort! { |a, b| a[sort_column] <=> b[sort_column] } if %[brewery beer style].include?(sort_column) && sort_direction == "asc"
      brs = brs.sort! { |a, b| b[sort_column] <=> a[sort_column] } if %[brewery beer style].include?(sort_column) && sort_direction == "desc"
      @beers = brs.paginate(:page => params[:page], :per_page => 10)
      render 'index'
    end
  end
  
  def get_beers
    if params[:search].present?
      @beers = Beer.search(params[:search]).includes(:ratings)
    else
      @beers = Beer.scoped.includes(:ratings)
    end
  end
  
  def order_beers
    %w[abv_int ibu_int average_rating rate].include?(sort_column) ? 
      @beers = @beers.reorder(sort_column + ' ' + un_sort_direction) : 
      @beers = @beers.reorder(sort_column + ' ' + sort_direction)
  end
  
  def get_ratings
    direction = params[:direction] == "asc" ? "desc" : "asc"
    ratings = current_user.ratings.order("rate" + ' ' + direction)
    ids = []
    ratings.each do |rating|
      ids << rating.beer_id
    end
    ids
  end
  
  def new
    @beer = Beer.new
  end
  
  def create
    @beer = Beer.create!(params[:beer])
    @beer.average_rating = @beer.rating_count = 0
    if @beer.save
      redirect_to beers_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    @beer = Beer.find(params[:id])
    @beer.update_attributes(params[:beer])
    respond_to do |format|
      format.html { redirect_to beers_path }
      format.js
    end
  end
  
  def destroy
    
  end
  
end
