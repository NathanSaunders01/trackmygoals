Rails.application.routes.draw do
  root to: 'pages#home'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :goals do
    resources :activities
  end
  
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  
  get 'about', to: 'pages#about'
  
  get 'dashboard', to: 'users#dashboard'
end
