class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :dob, :contact_no, :role, :confirmation_code, :email_verified, :avatar

  def email_verified
    object.confirmed_at.present? ? true : false
  end

  def avatar
    object.avatar.url
  end
end