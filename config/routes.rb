Rails.application.routes.draw do
  root to: 'home#index'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  get 'plants', to: 'plants#index'
  get 'plants/:plant_name', to: 'plants#show'

  get 'update_subcategories', to: 'application#update_subcategories'

  resources :cart, only: [:index, :create, :update, :destroy]

  get 'orders/index'
  get 'orders/show'
  get 'orders/create'

  get 'checkout', to: 'checkouts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations'}

  devise_scope :user do
    get 'account', to: 'users/registrations#show', as: 'user_account'
    put 'account', to: 'users/registrations#update', as: 'update_user_account'
    delete 'account', to: 'users/registrations#destroy', as: 'delete_user_account'
    delete 'users/sign_out', to: 'devise/sessions#destroy', as: 'destroy_user_session'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
