Rails.application.routes.draw do
  root to: 'pages#home'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :goals
  
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  
  get 'about', to: 'pages#about'
end
