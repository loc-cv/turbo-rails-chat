class Room < ApplicationRecord
  has_many :messages

  validates :name, presence: true, uniqueness: true

  scope :public_rooms, -> { where(is_private: false) }

  # Real time update the rooms list in the sidebar when a new room is created.
  after_create_commit { broadcast_append_to "rooms", partial: "rooms/room_navlink" }
end
