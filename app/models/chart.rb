# frozen_string_literal: true

class Chart < ApplicationRecord # :nodoc:
  validates :name, :description, presence: true

  belongs_to :workspace
  has_many :tasks, dependent: :restrict_with_exception
end
