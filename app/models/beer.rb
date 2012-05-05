class Beer < ActiveRecord::Base
  
  validates_presence_of :brewery, :brew
  # validates_numericality_of :abv_int, :ibu_int
  
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
    s = self.brew.split(' ')
    unless s.include?("ipa" || "IPA" || "Ipa")
      self.brew = self.brew.try(:titleize)
    else
      s.last 
    end
    self.brewery = self.brewery.try(:titleize)
    # self.style = self.style.try(:titleize) unless self.style == "IPA"
  end
  
end
