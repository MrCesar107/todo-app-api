# frozen_string_literal: true

FactoryBot.define do
  factory :chart do
    workspace
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
  end
end
