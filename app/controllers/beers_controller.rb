class BeersController < ApplicationController
  
  def index
    get_beers
    if @beers.empty?
      @beer = Beer.new
      render 'new'
    end
    @beers = @beers.paginate(:page => params[:page], :per_page => 10)
  end
  
  def my_beers
    get_beers
    brs = []
    get_ratings.each do |id|
      brs << @beers.find(id)
    end
    brs = brs.sort_by{|b| b[sort_column]} if %[abv_int ibu_int average_rating].include?(sort_column) && sort_direction == "asc"
    brs = brs.sort_by{|b| -b[sort_column]} if %[abv_int ibu_int average_rating].include?(sort_column) && sort_direction == "desc"
    brs = brs.sort! { |a, b| a[sort_column] <=> b[sort_column] } if %[brewery beer style].include?(sort_column) && sort_direction == "asc"
    brs = brs.sort! { |a, b| b[sort_column] <=> a[sort_column] } if %[brewery beer style].include?(sort_column) && sort_direction == "desc"
    @beers = brs.paginate(:page => params[:page], :per_page => 10)
    render 'index'
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
    redirect_to beers_path
  end
  
  def destroy
    
  end
  
end
