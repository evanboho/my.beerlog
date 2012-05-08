class Rating < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :beer
  serialize :tasted_on
  
  validates_presence_of :rate
  validates_inclusion_of :rate, :in => 0..11
  # validates_each :user_id, :beer_id do |record, attr, value|
  #   record.errors.add(attr, 'can only rate each beer once.') if 1 == 1
  # end
  validates_with UserBeerUniqueness

end