Rails.application.routes.draw do
  
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  authenticated :user do
    root 'goals#dashboard', as: :authenticated_root
  end
  
  root to: 'pages#home'

  resources :goals do
    resources :activities
  end
  
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  
  get 'about', to: 'pages#about'
  
  get 'dashboard', to: 'goals#dashboard'
end
