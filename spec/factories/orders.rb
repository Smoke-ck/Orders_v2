FactoryBot.define do
  factory :order do
    where { "MyString" }
    chek_out_time { "MyString" }
    active { false }
    body { "MyText" }
    user { nil }
  end
end
