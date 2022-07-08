# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :user
  belongs_to :menu_item
  validates :count, presence: true
  validates_uniqueness_of :user_id, scope: %i[order_id menu_item_id], message: "You can't review a product more than once"
end
