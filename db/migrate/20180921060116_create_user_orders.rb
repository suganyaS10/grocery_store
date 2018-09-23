class CreateUserOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :user_orders do |t|
      t.integer :user_id
      t.integer :order_id
      t.string :status

      t.timestamps
    end
  end
end
