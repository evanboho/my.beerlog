class Beer < ActiveRecord::Base
  
  validates_presence_of :brewery, :brew
  validates_numericality_of :abv_int, :ibu_int, allow_blank: true
  
  before_save :clean_up_brews
  
  has_many :ratings
  
  # private
  
  def self.searchh(search)
    search = titleize_and_upcase(search)
    results = Beer.where('brewery LIKE ?', "%#{search}%")
    if results.empty?
      results = Beer.where('brew LIKE ?', "%#{search}%")
    end
    if results.empty?
      results = Beer.where('style LIKE ?', "%#{search}%")
      # flash[:notice] = "No results were found."
    end
    results
  end
  
  def self.search(search)
    where("brewery ilike :s or brew ilike :s or style ilike :s", s: "%#{search}%")
  end
  
  def clean_up_brews
    self.brew = Beer.titleize_and_upcase(self.brew)
    self.brewery = self.brewery.try(:titleize)
    self.style = Beer.titleize_and_upcase(self.style)
  end
  
  def self.titleize_and_upcase(b)
    i = []
    b.split(' ').each do |f|
      i << (f.downcase != "ipa" ? f.try(:titleize) : f.try(:upcase))
    end
    i.join(' ')
  end
  
end
