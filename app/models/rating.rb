class Rating < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :beer
  serialize :tasted_on
  
  validates_presence_of :rate
  validates_inclusion_of :rate, :in => 0..11
  validates_numericality_of :rate
  validates :comment, :length => { :maximum => 200 }
  validate :user_beer_uniqueness, :on => :create
  
  def user_beer_uniqueness
    if Rating.find_by_user_id_and_beer_id(self.user_id, self.beer_id).present?
      errors.add(:rate, "You can't rate a beer more than once.")
    end
  end
  
end