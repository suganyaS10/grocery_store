# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :biller, class_name: 'User', foreign_key: :biller_id
  belongs_to :buyer, class_name: 'User', foreign_key: :buyer_id
  has_many :orders

  scope :unpaid_bills, -> { where(status: 'unpaid') }
  scope :paid_bills, -> { where(status: 'paid') }

  def self.generate_bill(current_user)
    orders = current_user.orders.includes(:inventory).current_orders
    bill_items = []
    bill_amount = 0
    buyer_id = orders.first.user.id

    orders.each do |order|
      bill_item_hash = {}
      item = order.inventory
      item_price = order.quantity * item.cost_per_unit
      bill_item_hash[:item_name] = item.item_name
      bill_item_hash[:quantity] = order.quantity
      bill_item_hash[:unit_price] = item.cost_per_unit
      bill_item_hash[:item_price] = item_price
      bill_items << bill_item_hash
      bill_amount += item_price
    end

    bill_code = generate_bill_code(current_user)
    orders.update_all(status: 'Complete')

    purchase = Purchase.create!(total_amount: bill_amount, biller_id:
      current_user.id, bill_code: bill_code, status: 'unpaid', buyer_id: buyer_id)

    { bill_items: bill_items, total_amount: bill_amount, purchase: purchase }
  end

  def self.generate_bill_code(user)
    Time.now.utc.to_s.delete(' ') + user.id.to_s
  end

  def self.generate_purchase_report(from, to)
    purchases = if from.present? && to.present?
                  Purchase.where('DATE(created_at) BETWEEN ? AND ?', from, to)
                elsif from.present?
                  Purchase.where('DATE(created_at) = ?', from)
                else
                  []
                end

    total_amount = purchases.sum(&:total_amount)

    { purchases: purchases, total: total_amount }
  end
end
