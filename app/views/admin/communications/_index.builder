q = QuerySpot.find params[:query_spot_id]
context.instance_eval  do
  table_for( q.feedbacks, :sortable => true, :class => 'index_table') do
    column :id
    column :user_role
    column "Scan" do |communication|
      communication.query_spot
    end
    column :message
    column :user
    column :created_at
    actions name: "Actions"
  end
end
