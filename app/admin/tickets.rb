ActiveAdmin.register Ticket, as: "Patient Tickets" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #

  remove_filter :inquiries
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :user_id
  #
  # or
  controller do
    def action_methods
      super - ['new', 'create', 'edit', 'update']
    end
  end


  index do
    selectable_column
    id_column
    column :user
    column :purpose
    column :title
    column "Image" do |ticket|
      ticket.image.present? ? 1 : 0
    end
    column :created_at
    actions name: "Actions"
  end

  show do |ticket|
    attributes_table do
      row :user
      row :purpose
      row :title
      row :image do |user|
        image_tag user.image.url, width: '100px', height: '100px' if user.image.present?
      end
      row :created_at
    end
  end
  #
  # permit_params do
  #   permitted = [:title, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
