ActiveAdmin.register Article do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :topic_id, images: []
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :topic_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :topic
    column :title
    column :description
    column :created_at
    column :updated_at
    actions name: "Actions"
  end

  show do |article|
    attributes_table do
      row :topic
      row :title
      row :description
      row "Images" do
         ul do
          article.images.each do |img|
            li do 
              image_tag img.url, width: '100px', height: '100px' if img.present?
            end
          end
         end
      end
      row :created_at
    end
  end

  form html: { multipart: true } do |f|
    f.inputs "Article" do
      f.input :topic
      f.input :title
      f.input :description
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end
end
