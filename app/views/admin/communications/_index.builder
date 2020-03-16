q = QuerySpot.find params[:query_spot_id]
context.instance_eval  do
  table_for( q.feedbacks, :sortable => true, :class => 'index_table') do
    column :id
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
