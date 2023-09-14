Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "welcome#index"

  get 'api/v1/users/:id/tasks', to: 'tasks#index'
  get 'api/v1/users/:id/tasks/:task_id', to: 'tasks#show'

  namespace :api do
    namespace :v1 do
      # namespace :users do
      #   namespace :id do
          resources :tasks
        end
    #   end
    # end
  end
end
