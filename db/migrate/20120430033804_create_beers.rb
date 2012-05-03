class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string  :brewery
      t.string  :brew
      t.integer :year
      t.string  :style
      t.string  :abv
      t.string  :ibu
      t.float   :average_rating
      t.integer :rating_count

      t.timestamps
    end
  end
end
