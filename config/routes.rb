Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/api/v1/chat_service', to: 'api/v1/breakdowns#show'
  get 'api/v1/holidays', to: "api/v1/holidays#index"
  get "api/v1/users/:user_id/daily_tasks", to: "api/v1/tasks#daily_tasks"

  get 'api/v1/users/:user_id/tasks', to: 'api/v1/tasks#index'
  post 'api/v1/users/:user_id/tasks', to: 'api/v1/tasks#create'
  get 'api/v1/users/:user_id/tasks/:id', to: 'api/v1/tasks#show'
  patch 'api/v1/users/:user_id/tasks/:id', to: 'api/v1/tasks#update'
  delete 'api/v1/users/:user_id/tasks/:id', to: 'api/v1/tasks#destroy'

  get 'api/v1/users/:user_id/calendar_events', to: 'api/v1/google_calendar#index'
end
