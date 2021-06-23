class Workspace < ApplicationRecord
  belongs_to :user
  has_many :charts, dependent: :restrict_with_exception

  validates :name, :user_id, presence: true
end
