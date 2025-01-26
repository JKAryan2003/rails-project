class User < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

	validates :first_name,presence: true
  validates :email,presence: true

  validate :must_have_roles

  private

  def must_have_roles
    if roles.empty?
			errors.add(:roles)
    end
  end
end
