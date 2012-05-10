class RatingsController < ApplicationController
  
  def create
    beer = Beer.find(params[:rating][:beer_id])
    @rating = beer.ratings.new( :rate => (params[:rating][:rate]).to_f.round(1), 
                                :user_id => current_user.id, 
                                :tasted_on => Date.today,
                                :comment => params[:rating][:comment])
    if @rating.save
      rating = beer.average_rating * beer.rating_count
      rating += @rating.rate
      beer.rating_count += 1
      beer.average_rating = ( rating / beer.rating_count ).round(2)
      beer.save
      flash.now[:notice] = "Woohoo! Beer = rated." 
    else 
      flash.now[:error] = "error. ratings only go from 0 - 10."
    end
    respond_to do |format|
      format.html {redirect_to beers_path}
      format.js { render 'create' }
    end
  end  
  
  def update
    @rating = Rating.find(params[:id])
    old_rating = @rating.rate
    if @rating.update_attributes(params[:rating])
      @rating.beer.average_rating = 
        (( @rating.beer.average_rating * @rating.beer.rating_count - old_rating + @rating.rate ) / @rating.beer.rating_count).round(2)
      @rating.beer.save 
      flash.now[:notice] = "rating updated!"
    else
      flash.now[:error] = "error. ratings only go from 0 - 10."
    end  
    respond_to do |format|
       format.html {redirect_to beers_path}
       format.js { render 'update' }
     end
  end
  
end