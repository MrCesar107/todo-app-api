# frozen_string_literal: true

FactoryBot.define do
  factory :workspace do
    user
    name { FFaker::Lorem.word }
  end
end
