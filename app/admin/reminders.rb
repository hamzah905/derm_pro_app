ActiveAdmin.register Reminder do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :title, :description
  #
  # or
  #
  controller do
    def scoped_collection
      super.where.not(user_id: nil)
    end
  end
  # or
  #
    index do
    if params[:user_id].present?
      render "index", context: self
    else
      selectable_column
      id_column
      column :user
      column :title
      column :description
      column :created_at
      actions name: "Actions"
    end
  end

  # permit_params do
  #   permitted = [:title, :description, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
