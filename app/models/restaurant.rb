# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :orders
  has_many :menu_items, dependent: :destroy
  validates :title, presence: true, length: { minimum: 2 }
end
