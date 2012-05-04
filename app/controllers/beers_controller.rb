class BeersController < ApplicationController
  
  def index
    get_beers
    if @beers.empty?
      @beer = Beer.new
      render 'new'
    end
    @beers.paginate(:page => params[:page], :per_page => 10)
  end
  
  def my_beers
    # ids = get_ratings
    get_beers
    brs = []
    get_ratings.each do |id|
      brs << @beers.find(id)
    end
    @beers = brs
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
