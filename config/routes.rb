Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  namespace :v0 do
    resources :teams, only: [:index]
    resources :permissions
    resources :entry_taggings
    resources :group_memberships
    resources :tags
    resources :groups
    resources :sessions, only: [:create]
    resources :user_activities
    resources :team_memberships
    resources :entries
    resources :users
  end

  root to: 'home#index'
end
