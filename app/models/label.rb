class Label < ApplicationRecord
  has_many :label_tasks, dependent: :restrict_with_exception
  has_many :tasks, through: :label_tasks
end
