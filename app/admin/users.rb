ActiveAdmin.register User do

  scope :All
  scope :patients
  scope :doctors
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :email, :password_digest, :gender, :dob, :is_activated, :contact_no, :role, :account_status, :uid, :SocialLogIn
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password_digest, :gender, :dob, :height, :martial_status, :education, :religious_education, :cast, :school_of_thoughts, :brothers, :sisters, :father_occupation, :occupation, :monthly_income, :residence, :city, :contact_no, :requirement, :account_status, :uid, :SocialLogIn, :registered]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      # f.input :gender
      f.input :dob
      f.input :contact_no
      f.input :account_status
      f.input :is_activated
      f.input :role
    end
    f.actions
  end
  
end
