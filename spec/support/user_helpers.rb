# frozen_string_literal: true

require 'ffaker'
require 'factory_bot_rails'

module UserHelpers
  def create_user
    FactoryBot.create(:user,
                      name: FFaker::Name.name,
                      email: FFaker::Internet.email,
                      username: FFaker::Internet.user_name,
                      password: FFaker::Internet.password)
  end

  def build_user
    FactoryBot.build(:user,
                     name: FFaker::Name.name,
                     email: FFaker::Internet.email,
                     username: FFaker::Internet.user_name,
                     password: FFaker::Internet.password)
  end
end
