class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_public_rooms, only: %i[index show]
  before_action :set_other_users, only: %i[index show]

  def index
    @room = Room.new
  end

  def show
    @room = Room.new
    @message = Message.new
    @current_room = Room.find(params[:id])
    @messages = @current_room.messages.order(created_at: :asc)
    render "index"
  end

  def create
    @room = Room.create(room_params)
  end

  private

    def room_params
      params.require(:room).permit(:name)
    end

    def set_public_rooms
      @public_rooms = Room.public_rooms
    end

    def set_other_users
      @other_users = User.all_except(current_user)
    end
end
