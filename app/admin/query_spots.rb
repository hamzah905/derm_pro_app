ActiveAdmin.register QuerySpot, as: "Scans" do

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
    column :disease
    column "Scan Place" do |query_spot|
      query_spot.query_spot_place
    end
    column "Scan Side" do |query_spot|
      query_spot.scan_side
    end
    column :message
    column "Images" do |query_spot|
      query_spot.images.count
    end
    column :created_at
  # actions name: "Actions"
    column "Actions" do |resource|
      links = link_to "View", resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, data: { :confirm => I18n.t('active_admin.delete_confirmation') } , :class => "member_link delete_link"
      links += link_to "Communications", {:controller => "admin/communications", :action => "index", :query_spot_id => resource.id }, :class => "member_link edit_link"
    end
  end

  show do |query_spot|
    attributes_table do
      row :user
      row :disease
      row :message
      row "Scan Place" do
        query_spot.query_spot_place
      end
      row "Scan Side" do
        query_spot.scan_side
      end
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
