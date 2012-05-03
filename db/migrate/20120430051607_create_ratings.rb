class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :beer_id
      t.float   :rate
      t.string  :tasted_on

      t.timestamps
    end
    add_index :ratings, [:user_id, :beer_id]
  end
end
