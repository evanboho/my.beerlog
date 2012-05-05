class Beer < ActiveRecord::Base
  
  validates_presence_of :brewery, :brew
  validates_numericality_of :abv_int, :ibu_int, allow_blank: true
  
  before_save :clean_up_brews
  
  has_many :ratings
  
  private
  
  def self.search(search)
    search = titleize_and_upcase(search.split(' '))
    # b = search.split(' ')
    #     i = []
    #     b.each do |f|
    #       f.downcase != "ipa" ? i << f.try(:titleize) : i << f.try(:upcase)
    #     end
    #     search = i.join(' ')
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
  
  def self.titleize_and_upcase(b)
    i = []
    b.each do |f|
      f.downcase != "ipa" ? i << f.try(:titleize) : i << f.try(:upcase)
    end
    i.join(' ')
  end
  
end
