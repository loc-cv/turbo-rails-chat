class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :body, presence: true

  # Send messages with real time update
  after_create_commit { broadcast_append_to room }

  # Make sure messages can't be sent (created) if sender is not a participant ...
  # ... of a private room even in the console.
  before_create :confirm_participant

  private

    def confirm_participant
      return unless room.is_private?

      is_participant = Participant.find_by(user_id: user.id, room_id: room.id)
      throw :abort unless is_participant
    end
end
