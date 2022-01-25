FactoryBot.define do
  factory :order do
    title { "MyString" }
    check_out { "14:00" }
    active { false }
    body { "MyText" }
    user { nil }
  end
end
