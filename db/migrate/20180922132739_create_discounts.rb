class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :discount_type
      t.string :discount_field
      t.string :discount_condition
      t.string :value
      t.string :discount_unit
      t.integer :discount_value

      t.timestamps
    end
  end
end
