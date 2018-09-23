# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :users

  ROLES_ARRAY = %w[Admin Shopper Staff].freeze

  ADMIN = 'Admin'.freeze
  SHOPPER = 'Shopper'.freeze
  STAFF = 'Staff'.freeze
end
