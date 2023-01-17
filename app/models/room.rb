class Room < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  scope :public_rooms, -> { where(is_private: false) }
end
