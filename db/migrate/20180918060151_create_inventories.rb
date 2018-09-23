class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.string :item_name, null: false
      t.string :category
      t.integer :quantity_available, null: false
      t.string :unit, null: false
      t.integer :cost_per_unit, null: false

      t.timestamps
    end
  end
end
