class BeersController < ApplicationController
  
  helper_method :sort_column, :sort_direction  
  
  def index
    get_beers
  end
  
  def my_beers
    
  end
  
  def new
    @beer = Beer.new
  end
  
  def create
    @beer = Beer.create!(params[:beer])
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
