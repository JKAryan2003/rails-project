class User < ApplicationRecord

  has_secure_password
  
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

	validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  
  validate :must_have_roles

  private

  def must_have_roles
    if roles.empty?
			errors.add(:roles)
    end
  end
end
