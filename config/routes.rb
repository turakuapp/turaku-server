Rails.application.routes.draw do
  apipie
  devise_for :users
  get 'home/index'

  scope 'api', defaults: { format: :json } do
    namespace :v0 do
      resources :teams, only: [:create]
      resources :permissions, only: %i[]
      resources :entry_taggings, only: %i[]
      resources :group_memberships, only: %i[]
      resources :tags, only: %i[]
      resources :groups, only: %i[]
      resource :session, only: %i[destroy]
      resources :sessions, only: %i[index create destroy]
      resources :user_activities, only: %i[]
      resources :team_memberships, only: %i[]
      resources :entries, only: %i[]

      resources :users, only: %i[create] do
        collection do
          get 'authentication_salt'
        end
      end
    end
  end

  root to: 'home#index'
end
