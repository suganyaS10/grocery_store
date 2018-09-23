class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.integer :total_amount
      t.integer :biller_id
      t.integer :buyer_id
      t.integer :bill_code
      t.string :status

      t.timestamps
    end

    add_column :orders, :purchase_id, :integer, index: true
  end
end
