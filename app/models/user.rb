# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :orders
  has_many :discounts, as: :entity
  has_many :purchases, class_name: 'Purchase', foreign_key: 'buyer_id'
  has_many :bills, class_name: 'Purchase', foreign_key: :biller_id

  before_validation :set_role

  def admin?
    return false unless role
    role.name == Role::ADMIN
  end

  def shopper?
    return false unless role

    role.name == Role::SHOPPER
  end

  def staff?
    return false unless role

    role.name == Role::STAFF
  end

  def set_role
    self.role_id = Role.find_by(name: Role::SHOPPER).id if role_id.blank?
  end
end
