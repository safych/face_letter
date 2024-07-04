Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :user_links, only: [:create, :update, :destroy]
  resource :profile, only: :show
  resources :users, only: :update

  root "home#index"
end
