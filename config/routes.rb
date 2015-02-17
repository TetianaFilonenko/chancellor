Rails.application.routes.draw do
  devise_for(
    :users,
    :skip => :registrations)
  root :to => 'home#index'

  namespace :admin do
    resources :users, :except => [:create, :destroy, :new] do
      resources :roles, :shallow => true, :only => [:create, :new]
      delete 'revoke_role/:role_name',
             :to => 'roles#destroy',
             :as => 'revoke_role'
    end
  end

  get 'versions/:item_type/:item_id', :as => :versions, :to => 'versions#index'
  get 'version/:id', :as => :version, :to => 'versions#show'
  resources :entities do
    resources :contacts, :shallow => true, :except => [:index]
    resources :customers, :shallow => true, :except => [:index]
    resources :locations, :shallow => true, :except => [:index]
    resources :salespeople, :shallow => true, :except => [:index]
  end
end
