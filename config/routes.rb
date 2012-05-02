Beerlog::Application.routes.draw do
  
  resources :authentications, :only => [:new, :create, :destroy]
  match 'users/auth/:provider/callback/' => 'authentications#create'
  
  devise_for :users do
    match "/sign_out" => "devise/sessions#destroy", :as => "sign_out"
  end
  
  resources :beers, :only => [ :index, :new, :create, :edit, :update ]

  resources :pages
  root :to => "pages#index"
  

  
end
