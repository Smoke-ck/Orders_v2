# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 5 }
  validates :check_out, presence: { message: "required and must be in the format XX:XX" }
end
