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
    def scoped_collection
      super.where.not(query_spot_id: nil)
    end
    def show
      @page_title = "Communication"
    end
  end
  #
  # permit_params do
  #   permitted = [:message, :query_spot_id, :image, :user_id, :user_role, :feedback_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    if params[:query_spot_id].present?
      render "index", context: self
    else
      selectable_column
      id_column
      column :user
      column :user_role
      column "Scan" do |communication|
        communication.query_spot
      end
      column :message
      column :query_spot_place
      column "Image" do |communication|
        communication.image.present? ? 1 : 0
      end
      column :created_at
      actions name: "Actions"
    end
  end

  show do |communication|
    attributes_table do
      row :user
      row :user_role
      row "Scan" do |communication|
        communication.query_spot
      end
      row :message
      row :query_spot_place
      row :image do |user|
        image_tag user.image.url, width: '100px', height: '100px' if user.image.present?
      end
      row :created_at
    end
  end

end
