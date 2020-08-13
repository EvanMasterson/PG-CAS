Rails.application.routes.draw do
  resources :users
  get 'dashboard/show'
  # resources :covid_api_data
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  match 'api/retrieve/data', to: 'api#retrieve_covid_data', via: [:get]
  match 'api/update/data', to: 'api#update_data_with_symptoms', via: [:put]

  get 'retrieve_data', to: 'welcome#retrieve_data'
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get 'dashboard' => 'dashboard#show'
  get 'logout' => 'logout#logout'#, via: :destroy
end
