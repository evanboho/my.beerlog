class Beer < ActiveRecord::Base
  
  validates_presence_of :brewery, :brew
  
  before_save :clean_up_brews
  
  has_many :ratings
  
  def self.search(search)
    results = Beer.where('brewery LIKE ?', "%#{search.try(:titleize)}%")   
    if results.empty?
      results = Beer.where('brew LIKE ?', "%#{search.try(:titleize)}%")   
    end
    results
  end
  
  private
  
  def clean_up_brews
    self.brew = self.brew.try(:titleize) unless self.brew.split(' ').last == "IPA"
    self.brewery = self.brewery.try(:titleize)
    # self.style = self.style.try(:titleize) unless self.style == "IPA"
  end
  
end
