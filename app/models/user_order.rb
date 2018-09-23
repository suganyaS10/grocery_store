# frozen_string_literal: true

class UserOrder < ApplicationRecord
  belongs_to :users
  belongs_to :orders

  state_machine :state, initial: :in_progress do
  end
end
