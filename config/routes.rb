Rails.application.routes.draw do
  root :to => 'entities#index'

  resources :entities
end
