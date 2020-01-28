class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :gender, :dob, :height, :martial_status, :education, :religious_education, :cast, :school_of_thoughts, :brothers, :sisters, :father_occupation, :occupation, :monthly_income, :residence, :city, :contact_no, :requirement, :account_status, :SocialLogIn, :registered
end