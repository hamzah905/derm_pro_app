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
      resources :topics, only: [:index]
      resources :articles, only: [:index]
      resources :inquires, only: [:create]
      resources :contact_us, only: [:create]
      resources :ratings, only: [:create, :update]
      resources :query_spots, only: [:create, :index, :show] do
      post "feedback", to: "query_spots#query_spot_feedback"
      end
      resources :tickets, only: [:create, :index]
      get "quiz/:id/questions", to: "questions#get_questions"
      get 'patients/:id', to: 'users#patient_detail'
      get 'all_patients', to: 'users#all_patients'
      get 'search_patients', to: "users#search_patients"
      get 'dashboard_graphs_user', to: "dashboard#dashboard_graphs_user"
      post 'update_user/:id', to: 'users#update_user'
      put 'update_contact_no/:id', to: 'users#update_contact_no'
      post "update_query_spot/:query_spot_id", to: "query_spots#update_query_spot"
      get "queryspot_listing_by_month", to: "query_spots#queryspot_listing_by_month"

			resources :users do
				collection do
					post "signup", to: "users#create"
					post 'login', to: 'authentication#authenticate'
					post 'forget_password', to: 'users#forget_password'
					post 'reset_password', to: 'users#change_password'
					get 'contact_us', to: 'users#contact_us'
          get 'check_email', to: 'users#check_email'
          post 'social_login', to: 'users#social_login_in'
          put 'verify_number', to: 'users#verify_number'
          put 'resend_otp', to: 'users#resend_otp'
          post 'attempt_quiz', to: 'users#attempt_quiz'
          post 'create_reminder', to: 'users#create_reminder'
				end
			end
		end
	end
end
