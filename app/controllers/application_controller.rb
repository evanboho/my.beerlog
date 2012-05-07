class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :sort_column, :sort_direction
  
  def sort_column
    unless params[:sort] == "rate"
      Beer.column_names.include?(params[:sort]) ? params[:sort] : "average_rating" 
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
