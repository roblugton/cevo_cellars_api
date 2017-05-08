class CreateBottles < ActiveRecord::Migration[5.1]
  def change
    create_table :bottles do |t|
      t.string :name
      t.string :winery
      t.integer :vintage
      t.string :description
      t.references :cellar, foreign_key: true

      t.timestamps
    end
  end
end
