class Chart < ApplicationRecord
  belongs_to :workspace
  has_many :tasks, dependent: :restrict_with_exception
end
