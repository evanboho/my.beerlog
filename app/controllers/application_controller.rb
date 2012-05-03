class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :sort_column, :sort_direction
  
  def get_beers
    if params[:search].present?
      @beers = Beer.search(params[:search])
    else
      @beers = Beer.scoped
    end
    @beers = @beers.reorder(sort_column + ' ' + sort_direction) unless sort_column == "rate"
  end
  
  def get_ratings
    direction = params[:direction] == "asc" ? "desc" : "asc"
    ratings = current_user.ratings
    ratings = ratings.reorder("rate" + ' ' + direction)
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
  
end
