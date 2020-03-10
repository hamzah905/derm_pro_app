class Api::V1::DashboardController < Api::V1::BaseController

  def dashboard_graphs_user
    user_per_day = {}
    ["1", "2", "3","4","5","6"].each_with_index do |day, index|
      @date = (DateTime.now) - ((index + 1) * 7).days
      @users = User.where(role: "patient", :created_at => @date..DateTime.now - (index * 7).days)
      user_per_day[day] = @users.count
    end
    doctor_subscription_rate = (User.where(role: "doctor", is_activated: true).count * 100) / User.where(role: "doctor").count
    pending_qs = QuerySpot.includes(:feedbacks).where(:feedbacks => { :id => nil }).count
    reports_pending_ratio = (pending_qs.count * 100)/QuerySpot.count
    response = { message: "User Per Day", user: {user_per_day: user_per_day, doctor_subscription_rate: doctor_subscription_rate, reports_pending_ratio: reports_pending_ratio}, auth_token: auth_token }
    json_response(response)
  end

end
