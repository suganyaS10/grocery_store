# frozen_string_literal: true

class Order < ApplicationRecord
  
  belongs_to :inventory
  belongs_to :user

  validate :uniq_open_orders

  scope :current_orders, -> { where(status: 'in_progress') }

  def self.add_item_to_cart(item_name, quantity, current_user)
    inventory = Inventory.find_by(item_name: item_name)
    ordered_inventories = current_user.orders.includes(:inventory).current_orders

    if quantity.to_i > inventory.quantity_available
      return { remaining_quantity:
        inventory.quantity_available }
    end

    remaining_quantity = inventory.quantity_available - quantity.to_i
    inventory.update_attributes!(quantity_available: remaining_quantity)

    if ordered_inventories.map(&:inventory).map(&:item_name).include?(item_name)
      order = ordered_inventories.detect { |ord| ord.inventory_id == 1 }
      order.update_attributes!(quantity: quantity)
    else
      Order.create!(inventory_id: inventory.id, quantity: quantity,
                    user_id: current_user.id, status: 'in_progress')
    end

    { remaining_quantity: remaining_quantity }
  end

  def self.remove_item_from_cart(item_name, quantity, current_user)
    inventory = Inventory.find_by(item_name: item_name)
    remaining_quantity = inventory.quantity_available + quantity.to_i

    inventory.update_attributes!(quantity_available: remaining_quantity)

    Order.where(inventory_id: inventory.id, user_id: current_user.id,
                status: 'in_progress').destroy

    { remaining_quantity: remaining_quantity }
  end

  def uniq_open_orders
  	order = Order.find_by(inventory_id: self.inventory_id, user_id: 
  		self.user_id, status: 'in_progress')

  	self.errors.add(:inventory, 'Already in the cart') if order.present?
  end


end
