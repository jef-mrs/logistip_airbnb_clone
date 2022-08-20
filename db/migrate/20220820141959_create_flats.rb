class CreateFlats < ActiveRecord::Migration[6.1]
  def change
    create_table :flats do |t|
      t.string :title
      t.text :address
      t.text :description
      t.integer :price_per_day
      t.integer :capacity

      t.timestamps
    end
  end
end
