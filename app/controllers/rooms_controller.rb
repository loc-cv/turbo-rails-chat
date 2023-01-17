class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @public_rooms = Room.public_rooms
    @other_users = User.all_except(current_user)
  end
end
