ActiveAdmin.register User do

  scope :All
  scope :patients
  scope :doctors
  filter :first_name
  filter :last_name
  filter :email
  filter :dob
  filter :contact_no
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :email, :password, :avatar, :gender, :dob, :is_activated, :contact_no, :role, :account_status, :uid, :SocialLogIn
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password_digest, :gender, :dob, :height, :martial_status, :education, :religious_education, :cast, :school_of_thoughts, :brothers, :sisters, :father_occupation, :occupation, :monthly_income, :residence, :city, :contact_no, :requirement, :account_status, :uid, :SocialLogIn, :registered]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :dob
    column :contact_no
    # column :SocialLogIn
    # column :is_activated
    column :role
    column :created_at
    column :updated_at
    actions name: "Actions"
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :avatar do |user|
        image_tag user.avatar.url, width: '100px', height: '100px' if user.avatar.present?
      end
      row :dob
      row :contact_no
      row :is_activated
      row :role
      row :created_at
      row :updated_at
    end
  end


  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      if f.object.avatar.url
        f.input :avatar, as: :file, hint: image_tag(f.object.avatar.url, width: '100px', height: '100px')
      else
        f.input :avatar, as: :file
      end
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
