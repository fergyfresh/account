Rails.application.routes.draw do
  devise_for :users
  resources :time_records
  resources :records
  resources :users
  resources :relationships,       only: [:create, :destroy]
  patch  'promote' => 'users#promote'
  patch  'demote' => 'users#demote'

  devise_scope :user do
    authenticated :user do
      root 'records#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
