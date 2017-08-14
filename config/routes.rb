Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  scope 'api' do
    namespace :v0 do
      resources :teams, only: [:index]
      resources :permissions
      resources :entry_taggings
      resources :group_memberships
      resources :tags
      resources :groups
      resource :session, only: %i[destroy]
      resources :sessions, only: %i[index create destroy]
      resources :user_activities
      resources :team_memberships
      resources :entries
      resources :users
    end
  end

  root to: 'home#index'
end
