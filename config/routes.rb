Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # mount RailsAdmin::Engine => '/', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	namespace :api, defaults: { format: :json } do
		namespace :v1 do

			resources :users do
				collection do
					post "signup", to: "users#create"
					post 'login', to: 'authentication#authenticate'
					post 'forget_password', to: 'users#forget_password'
					post 'reset_password', to: 'users#change_password'
					get 'contact_us', to: 'users#contact_us'
          post 'social_login', to: 'users#social_login_in'
				end
			end
		end
	end
end
