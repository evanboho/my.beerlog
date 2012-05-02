class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :sort_column, :sort_direction
  
  def get_beers
    if params[:search].present?
      @beers = Beer.search(params[:search])
    else
      @beers = Beer.scoped
    end
    @beers = @beers.reorder(sort_column + ' ' + sort_direction)
  end
  
  def sort_column
    Beer.column_names.include?(params[:sort]) ? params[:sort] : "brewery"  
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
