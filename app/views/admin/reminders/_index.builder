q = User.find params[:user_id]
context.instance_eval  do
  table_for( q.reminders, :sortable => true, :class => 'index_table') do
    column :id
    column :title
    column :description
    column :created_at
    actions name: "Actions"
  end
end
