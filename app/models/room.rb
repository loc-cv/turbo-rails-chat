class Room < ApplicationRecord
  has_many :messages
  has_many :participants, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :public_rooms, -> { where(is_private: false) }

  # Real time update the rooms list in the sidebar when a new PUBLIC room is created.
  after_create_commit { broadcast_if_public }

  def self.create_private_room(users, room_name)
    room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: room.id)
    end
    room
  end

  private

    def broadcast_if_public
      return if is_private?

      broadcast_append_to "rooms", partial: "rooms/room_navlink"
    end
end
