# frozen_string_literal: true

FactoryBot.define do
  factory :workspace do
    name { FFaker::Lorem.word }
  end
end
