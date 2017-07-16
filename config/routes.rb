Rails.application.routes.draw do
  resources :permissions
  resources :entry_taggings
  resources :group_memberships
  resources :tags
  resources :groups
  resources :sessions
  resources :user_activities
  resources :team_memberships
  resources :entries
  resources :users
  namespace :v0 do
    resources :teams, only: [:index]
  end
end
