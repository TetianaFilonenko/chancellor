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

  get 'entities/:id/versions', :to => 'entities/versions#index'
  resources :entities do
    resources :locations, :shallow => true, :only => [:edit, :update]
  end
end
