class User < ApplicationRecord
  has_many :messages
  has_one_attached :avatar

  enum status: %i[offline away online]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user) }

  # Real time update the users list in the sidebar when a new user signs up.
  after_create_commit { broadcast_append_to "users", partial: "users/user_navlink" }

  after_update_commit { broadcast_update_status }

  after_commit :add_default_avatar, on: %i[create update]

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [50, 50]).processed
  end

  def chat_avatar
    avatar.variant(resize_to_limit: [40, 40]).processed
  end

  def is_participant_of?(room)
    room.participants.where(user: self).exists?
  end

  private

    def broadcast_update_status
      broadcast_replace_to "user_status", partial: "users/status"
    end

    def add_default_avatar
      return if avatar.attached?

      avatar.attach(
        io: File.open(Rails.root.join("app", "assets",
                                      "images", "default_avatar.png")),
        filename: "default_avatar.png",
        content_type: "image/png"
      )
    end
end
