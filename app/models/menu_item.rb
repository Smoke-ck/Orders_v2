# frozen_string_literal: true

class MenuItem < ApplicationRecord
  belongs_to :restaurant
  validates :title, presence: true, length: { minimum: 2 }
  validates :price, presence: true, length: { maximum: 6, message: "should be in the format is XXX.XX" }
end
