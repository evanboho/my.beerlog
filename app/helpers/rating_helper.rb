module RatingHelper
  
  def find_rating(user_id, beer_id)
    Rating.find_or_create_by_user_id_and_beer_id(user_id, beer_id)
  end  


end
