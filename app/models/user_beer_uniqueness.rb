class UserBeerUniqueness < ActiveModel::Validator
  def validate(record)
    if Rating.find_by_user_id_and_beer_id(record.user_id, record.beer_id).present?    
      record.errors[:base] << 'You may only leave one rating per beer.'
    end
  end
  
end