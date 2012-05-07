class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :sort_column, :sort_direction
  
  def get_beers
    if params[:search].present?
      @beers = Beer.search(params[:search])
    else
      @beers = Beer.scoped
    end
    unless params[:sort] == "rate"
    %w[abv_int ibu_int average_rating rate].include?(sort_column) ? 
      @beers = @beers.reorder(sort_column + ' ' + un_sort_direction) : 
      @beers = @beers.reorder(sort_column + ' ' + sort_direction)
    end
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
  
  def sort_column
    unless params[:sort] == "rate"
      Beer.column_names.include?(params[:sort]) ? params[:sort] : "brewery" 
    else
      "rate"
    end
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"  
  end
  
  def un_sort_direction
    sort_direction == "asc" ? "desc" : "asc"
  end
  
end
