Rails.application.routes.draw do
  
  
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  
  authenticated :user do
    root 'users#dashboard', as: :authenticated_root
  end
  
  resources :users, only: [] do
    collection do
      get 'goal_xp_by_day'
      get 'goal_xp_by_week'
      get 'goal_xp_by_month'
    end
  end
  
  root to: 'pages#home'

  resources :goals, :path => 'tasks' do
    member do
  		patch :complete
  		put :duplicate
  	end
  	resources :activities
  end
  
  resources :rewards
  
  resources :contacts, only: :create
  get 'feedback', to: 'contacts#new', as: 'new_contact'
  get 'view-feedback', to: 'contacts#index', as: 'view_feedback'
  
  get 'about', to: 'pages#about'
  
  get 'dashboard', to: 'users#dashboard'
  get 'dashboardtest', to: 'users#dashboardtest'
end
