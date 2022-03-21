# frozen_string_literal: true

class MenuItem < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
  validates :title, presence: true, length: { minimum: 2 }
  validates :price, presence: true, format: { with: /\A\d{1,3}(\.\d{1,2})?\z/, message: "should be in the format is XXX.XX" }
end
