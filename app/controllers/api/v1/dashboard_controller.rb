class Api::V1::DashboardController < Api::V1::BaseController

  def dashboard_graphs_user
    user_per_day = {}
    ["1", "2", "3","4","5","6"].each_with_index do |day, index|
      @date = (DateTime.now) - ((index + 1) * 7).days
      @users = User.where(role: "patient", :created_at => @date..DateTime.now - (index * 7).days)
      user_per_day[day] = @users.count
    end
    reviewed_users = Feedback.where(user_role: "patient").pluck(:user_id).uniq
    user_satisfaction_rate = (reviewed_users.count * 100) / User.where(role: "patient").count
    pending_qs = QuerySpot.includes(:feedbacks).where(:feedbacks => { :id => nil }, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
    reports_pending_ratio = (pending_qs != 0) ? (pending_qs * 100) / QuerySpot.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count : 0
    doctor_percentage = (User.where(role: "doctor").count * 100) / User.count
    patient_percentage = (User.where(role: "patient").count * 100) / User.count
    response = { message: "User Per Day", user: {user_per_day: user_per_day, user_satisfaction_rate: user_satisfaction_rate, reports_pending_ratio: reports_pending_ratio, doctor_with_patient_percentage: {doctor: doctor_percentage, patient: patient_percentage}}, auth_token: auth_token }
    json_response(response)
  end

end
