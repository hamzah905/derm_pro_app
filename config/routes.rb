Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # mount RailsAdmin::Engine => '/', as: 'rails_admin'
  root to: redirect('/admin')
  devise_for :users, controllers: { confirmations: 'confirmations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home/account_verification'

	namespace :api, defaults: { format: :json } do
		namespace :v1 do

      resources :questions, only: [:index]
      resources :quizzes, only: [:index]
      get "quiz/:id/questions", to: "questions#get_questions"

			resources :users do
				collection do
					post "signup", to: "users#create"
					post 'login', to: 'authentication#authenticate'
					post 'forget_password', to: 'users#forget_password'
					post 'reset_password', to: 'users#change_password'
					get 'contact_us', to: 'users#contact_us'
          post 'social_login', to: 'users#social_login_in'
          post 'attempt_quiz', to: 'users#attempt_quiz'
				end
			end
		end
	end
end
