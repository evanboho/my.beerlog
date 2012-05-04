class AddIbuIntToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :ibu_int, :integer

  end
end
