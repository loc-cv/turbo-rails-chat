module UsersHelper
  def status_to_css(user)
    case user.status
    when "online"
      "bg-green-400"
    when "offline"
      "bg-gray-600"
    when "away"
      "bg-yellow-300"
    else
      "bg-gray-600"
    end
  end
end
