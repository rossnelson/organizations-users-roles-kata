Rails.application.routes.draw do
  get 'orgs' => 'orgs#index'

  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
end
