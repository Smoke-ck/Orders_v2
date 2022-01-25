class Order < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 5 }
end


# /\b(?:[01]?[0-9]|2[0-3]):[0-5][0-9]\b/