# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  validates :body, presence: true, length: { minimum: 5 }
  validates :check_out, presence: true
end
