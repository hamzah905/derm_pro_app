class Api::V1::DashboardController < Api::V1::BaseController

  def dashboard_graphs_user
    user_per_day = {}
    ["1", "2", "3","4","5","6","7","8","9","10","11","12"].each_with_index do |day, index|
      @date = (DateTime.now) - ((index + 1) * 7).days
      @users = User.where(:created_at => @date..DateTime.now - (index * 7).days)
      user_per_day[day] = @users.count
    end
    response = { message: "User Per Day", user: user_per_day, auth_token: auth_token }
    json_response(response)
  end

end
