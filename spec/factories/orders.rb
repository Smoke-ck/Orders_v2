# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    check_out { "14:00" }
    active { false }
    body { "MyText" }
    user { nil }
  end
end
