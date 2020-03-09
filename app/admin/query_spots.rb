ActiveAdmin.register QuerySpot do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :message, :images
  #
  # or
  remove_filter :feedbacks
  #
  # permit_params do
  #   permitted = [:message, :images]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def action_methods
      super - ['new', 'create', 'edit', 'update']
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :message
    column "Images" do |query_spot|
      query_spot.images.count
    end
    column :created_at
    actions name: "Actions"
  end

  show do |query_spot|
    attributes_table do
      row :user
      row :message
      row "Images" do
         ul do
          query_spot.images.each do |img|
            li do 
              image_tag img.url, width: '100px', height: '100px' if img.present?
            end
          end
         end
      end
      row :created_at
    end
  end
  
end
