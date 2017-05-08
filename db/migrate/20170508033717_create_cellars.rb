class CreateCellars < ActiveRecord::Migration[5.1]
  def change
    create_table :cellars do |t|
      t.string :name

      t.timestamps
    end
  end
end
