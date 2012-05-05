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
    self.brew = titleize_and_upcase(self.brew.split(' '))
    self.brewery = self.brewery.try(:titleize)
    self.style = titleize_and_upcase(self.style.split(' '))
  end
  
  def titleize_and_upcase(b)
    i = []
    b.each do |f|
      f.downcase != "ipa" ? i << f.try(:titleize) : i << f.try(:upcase)
    end
    i.join(' ')
  end
  
end
