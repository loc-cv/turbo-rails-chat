class UsersController < ApplicationController
  before_action :set_public_rooms, only: [:show]
  before_action :set_other_users, only: [:show]

  def show
    @room = Room.new
    @message = Message.new
    @user = User.find(params[:id])
    @private_room_name = get_private_room_name(@user, current_user)
    @current_room = Room.find_by(name: @private_room_name) ||
                    Room.create_private_room([@user, current_user], @private_room_name)
    @messages = @current_room.messages.order(created_at: :asc)
    render "rooms/index"
  end

  private

    def get_private_room_name(first_user, second_user)
      users = [first_user, second_user].sort
      "private_#{users[0].id}_#{users[1].id}"
    end

    def set_public_rooms
      @public_rooms = Room.public_rooms
    end

    def set_other_users
      @other_users = User.all_except(current_user).order(created_at: :asc)
    end
end
