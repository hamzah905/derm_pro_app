module ApplicationHelper

  def send_notification(registration_id, title, body, notification_type, user_id)
    gcm = FCM.new("AIzaSyCw2BtI1LzmfMbwtgmbdmJbuwf8s0jcvdI")
    # registration_id = "e3L1MxtipnU:APA91bEh1g8Nxq1bP8W7VGbMsDSHvjU38cEZ8eMbvEkj-6lwfxYcmGcut-r5RNa0Zqa_TpIV-oDsYmONsHLJSDnPKBGqoBWkE22XP6uGEVwwUF6U1pLRQH6ioy1z50LMM8I54HUCBCd1"

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
