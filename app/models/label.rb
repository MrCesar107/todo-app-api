class Label < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :label_tasks, dependent: :restrict_with_exception
  has_many :tasks, through: :label_tasks
  belongs_to :user
end
