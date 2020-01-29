ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    
    columns :class => 'column--left' do
      columns do
        column do
          panel "Total Users" do
           h2 User.count
          end
        end

        column do
          panel "Total Patients" do
            h2 User.where(role: "patient").count
          end
        end

        column do
          panel "Total Doctors" do
            h2 User.where(role: "doctor").count
          end
        end
      end
    end
  end
end
