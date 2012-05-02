class BeersController < ApplicationController
  
  helper_method :sort_column, :sort_direction  
  
  def index
    if params[:search].present?
      @beers = Beer.search(params[:search])
    else
      @beers = Beer.scoped
    end
    @beers = @beers.reorder(sort_column + ' ' + sort_direction)
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
  
  private
  
  def sort_column
    Beer.column_names.include?(params[:sort]) ? params[:sort] : "brewery"  
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
