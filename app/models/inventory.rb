class Inventory < ApplicationRecord
  has_many :orders
  has_many :discounts, as: :entity
  validates :item_name, uniqueness: true

  UNITS_ARRAY = %w[kg l m pc].freeze
  CATEGORY_ARRAY = %w[vegetables fruits grocery beverages 
  	snacks toileteries].freeze

  def self.generate_stock_report
    Inventory.all
  end
end
