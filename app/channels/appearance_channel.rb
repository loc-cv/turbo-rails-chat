class AppearanceChannel < ApplicationCable::Channel
  def subscribed
  end

  def unsubscribed
    offline
  end

  def online
    status = User.statuses[:online]
    update_current_user_status(status)
  end

  def offline
    status = User.statuses[:offline]
    update_current_user_status(status)
  end

  def away
    status = User.statuses[:away]
    update_current_user_status(status)
  end

  def receive(data)
  end

  private

    def update_current_user_status(status)
      current_user.update!(status:)
    end
end
