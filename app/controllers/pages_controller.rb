class PagesController < ApplicationController
  
  def index
    @beers = Beer.all
  end
end
