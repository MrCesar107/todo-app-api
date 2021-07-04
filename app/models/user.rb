class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :email, :username, uniqueness: true
  validates :name, :username, :email, :password, presence: true
  validates_confirmation_of :password

  has_many :workspaces, dependent: :restrict_with_exception
  has_many :labels
end
