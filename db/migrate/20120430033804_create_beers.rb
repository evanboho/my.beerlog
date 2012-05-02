class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string  :brewery
      t.string  :brew
      t.integer :year
      t.string  :style
      t.string  :abv
      t.string  :ibu

      t.timestamps
    end
  end
end
