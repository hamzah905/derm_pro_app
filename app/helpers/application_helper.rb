module ApplicationHelper

  def send_notification(registration_id, title, body, notification_type, user_id, obj_id)
    gcm = FCM.new("AIzaSyBRrpMkzJg2ZvOTgyyGGa4ROCpeZVa6-Fo")
    registration_id = ["fW6LZ2r5Fgo:APA91bGlOyd9rfzPqoU9qRkqKxagKQQcu8coBOKNiD6YgelBd34zuYu268EbP2KZLKzNoDTHVCtPRZbhXCx1x6xsuBlfs_1_UwEtbR4GEmO_kEQZyVop8vyIA3pE23-DoxdZVeG7tsjp"] unless registration_id.present?
    options = {}
    options[:notification] = {}
    options[:notification][:title] = "#{title}"
    options[:notification][:body] = "#{body}"
    options[:content_available] = true
    options[:data] = {}
    options[:data][:user_id] = user_id
    options[:data][:obj_id] = obj_id
    options[:data][:notification_type] = notification_type
    options[:priority] = "high"
    puts "================#{options}=========================="
    @fcm_response = gcm.send(registration_id, options)
    notification = JSON.parse(@fcm_response[:body])
    puts "================#{@fcm_response}========================"
    puts "================#{notification}========================"
  end

end
