class AddAbvIntToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :abv_int, :float

  end
end
