class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user) }

  # Real time update the users list in the sidebar when a new user signs up.
  after_create_commit { broadcast_append_to "users", partial: "users/user_navlink" }
end
