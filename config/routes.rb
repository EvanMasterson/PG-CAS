Rails.application.routes.draw do
  resources :users
  get 'dashboard/show'
  resources :covid_api_data
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  match 'api/coviddata', to: 'api#coviddata', via: [:get, :post]
  match 'api/updaterisklevel', to: 'api#updateApiDataWithRiskLevel', via: [:post]

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get 'dashboard' => 'dashboard#show'
  get 'logout' => 'logout#logout', via: :destroy
end
