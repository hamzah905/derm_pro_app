ActiveAdmin.register Feedback, as: "Communication" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  filter :query_spot, label: 'Scan'
  filter :user
  filter :message
  filter :created_at
  filter :user_role
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :message, :query_spot_id, :image, :user_id, :user_role, :feedback_type
  #
  # or

  controller do
    def action_methods
      super - ['new', 'create', 'edit', 'update']
    end
  end
  #
  # permit_params do
  #   permitted = [:message, :query_spot_id, :image, :user_id, :user_role, :feedback_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :user_role
    column "Scan" do |feedback|
      feedback.query_spot
    end
    column :message
    column :user
    column :created_at
    actions name: "Actions"
  end

  show do |feedback|
    attributes_table do
      row :user_role
      row "Scan" do |feedback|
        feedback.query_spot
      end
      row :message
      row :user
      row :image do |user|
        image_tag user.image.url, width: '100px', height: '100px' if user.image.present?
      end
      row :created_at
    end
  end

end
