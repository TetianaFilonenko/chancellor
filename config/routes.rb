Rails.application.routes.draw do
  devise_for(
    :users,
    :skip => :registrations)
  root :to => 'home#index'

  resources :entities
end
