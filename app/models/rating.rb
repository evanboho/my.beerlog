class Rating < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :beer
  serialize :tasted_on
  
  validates_presence_of :rate, :tasted_on
  validates_inclusion_of :rate, :in => 0..11
  
end
