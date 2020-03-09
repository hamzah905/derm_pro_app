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
      resources :query_spots, only: [:create, :index, :show] do
      post "feedback", to: "query_spots#query_spot_feedback"
      end
      resources :tickets, only: [:create, :index]
      get "quiz/:id/questions", to: "questions#get_questions"
      get 'patients/:id', to: 'users#patient_detail'
      get 'all_patients', to: 'users#all_patients'
      get 'search_patients', to: "users#search_patients"
      get 'dashboard_graphs_user', to: "dashboard#dashboard_graphs_user"

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
