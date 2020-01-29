class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :dob, :contact_no, :confirmation_code
end