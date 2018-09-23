# frozen_string_literal: true

class Discount < ApplicationRecord
  belongs_to :entity, polymorphic: true

  DISCOUNTABLE = { 'Role': ['Name'], 'Inventory': %w[ItemName Category] }.freeze
end
