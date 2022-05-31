require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  mount Sidekiq::Web => '/sidekiq'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#index"

  namespace :api do
    namespace :v1 do
      resources :file_cnabs, only: %w[index] do
        collection do
          post :process_file
        end
      end
      resources :import_files, only: %w[index show]
      resources :companies, only: %w[index show]
    end
  end
end
