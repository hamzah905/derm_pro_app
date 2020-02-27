module ApplicationHelper

  def send_notification(registration_id, title, body, notification_type, user_id)
    gcm = FCM.new("AIzaSyCw2BtI1LzmfMbwtgmbdmJbuwf8s0jcvdI")
    registration_id ||= "fMdVhOMHbwY:APA91bENliUGl2crNaxwodo3hdEs6-tGSi7PlgPgi4Mk06ywn4YeUYjNvubQqbdgFHnhr9ZrEiOTeJES9-ThaIR0r3Uu0KRTXMLVc21dhvHT0peHjCR6VsvCVWID1gqEq4ucYgHStmCn"

    options = {}
    options[:notification] = {}
    options[:notification][:title] = "#{title}"
    options[:notification][:body] = "#{body}"
    options[:content_available] = true
    options[:data] = {}
    options[:data][:user_id] = user_id
    options[:data][:notification_type] = notification_type
    options[:priority] = "high"
    puts "================#{options}=========================="
    @fcm_response = gcm.send(registration_id, options)
    notification = JSON.parse(@fcm_response[:body])
    puts "================#{@fcm_response}========================"
  end

end
