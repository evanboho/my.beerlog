class Rating < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :beer
  serialize :tasted_on
  
  validates_presence_of :rate
  validates_inclusion_of :rate, :in => 0..11
  validates_numericality_of :rate
  # validates_each :user_id, :beer_id do |record, attr, value|
  #   record.errors.add(attr, 'can only rate each beer once.') if 1 == 1
  # end
  # validates_with UserBeerUniqueness, :except => [ :update ]
  validate :user_beer_uniqueness, :on => :create
  
  def user_beer_uniqueness
    if Rating.find_by_user_id_and_beer_id(self.user_id, self.beer_id).present?
      errors.add(:rate, "You can't rate a beer more than once.")
    end
  end
  
end