class RatingsController < ApplicationController
  
  def create
    beer = Beer.find(params[:rating][:beer_id])
    @rating = beer.ratings.create(:rate => params[:rating][:rate], :user_id => current_user.id, :tasted_on => Date.today)
    rating = beer.average_rating * beer.rating_count
    rating += @rating.rate
    beer.rating_count += 1
    beer.average_rating = rating / beer.rating_count
    if beer.save
      redirect_to beers_path
    else 
      flash[:notice] = "OOps."
      redirect_to beers_path
    end
  end  
  
  def update
    @rating = Rating.find(params[:id])
    @rating = @rating.update_attributes(params[:rating])
    redirect_to beers_path
  end
  
end