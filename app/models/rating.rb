class Rating < ActiveRecord::Base
  
  belongs_to :user 
  serialize :tasted_on
  
  validates_presence_of :rate, :tasted_on
  
end
