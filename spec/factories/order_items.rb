FactoryBot.define do
  factory :order_item do
    count { 1 }
    order { nil }
    user { nil }
  end
end
