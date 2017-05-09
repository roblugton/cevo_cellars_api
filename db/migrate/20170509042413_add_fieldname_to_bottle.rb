class AddFieldnameToBottle < ActiveRecord::Migration[5.1]
  def change
    add_column :bottles, :varietal, :string
  end
end
