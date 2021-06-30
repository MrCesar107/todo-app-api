# frozen_string_literal: true

class Task < ApplicationRecord # :nodoc:
  validates :name, :description, presence: true

  belongs_to :chart
  has_many :label_tasks, dependent: :restrict_with_exception
  has_many :labels, through: :label_tasks
end
