# frozen_string_literal: true

FactoryBot.define do
  factory :label do
    user
    name { FFaker::Lorem.word }
    color { "##{FFaker::Color.hex_code}" }
  end
end
