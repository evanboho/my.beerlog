class Beer < ActiveRecord::Base
  
  validates_presence_of :brewery, :brew
  validates_numericality_of :abv_int, :ibu_int, allow_blank: true
  
  before_save :clean_up_brews
  
  has_many :ratings
  
  # private
  
  def self.search(search)
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
  
  def clean_up_brews
    self.brew = self.titleize_and_upcase(self.brew)
    self.brewery = self.brewery.try(:titleize)
    self.style = self.titleize_and_upcase(self.style)
  end
  
  def titleize_and_upcase(b)
    i = []
    b.split(' ').each do |f|
      i << (f.downcase != "ipa" ? f.try(:titleize) : f.try(:upcase))
    end
    i.join(' ')
  end
  
  def self.titleize_and_upcase(b)
    i = []
    b.split(' ').each do |f|
      i << (f.downcase != "ipa" ? f.try(:titleize) : f.try(:upcase))
    end
    i.join(' ')
  end
  
end
