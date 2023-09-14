Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/api/v1/chat_service', to: 'api/v1/breakdowns#show'
  get 'api/v1/holidays', to: "api/v1/holidays#index"

  get 'api/v1/users/:id/tasks', to: 'tasks#index'
  get 'api/v1/users/:id/tasks/:task_id', to: 'tasks#show'


end
