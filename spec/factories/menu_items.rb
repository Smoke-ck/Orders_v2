# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    title { "MyString" }
    price { "9.99" }
    restaurant { nil }
  end
end
