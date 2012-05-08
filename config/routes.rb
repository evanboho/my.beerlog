Beerlog::Application.routes.draw do
  
  resources :authentications, :only => [:new, :create, :destroy]
  match 'users/auth/:provider/callback/' => 'authentications#create'
  
  devise_for :users do
    match "/sign_out" => "devise/sessions#destroy", :as => "sign_out"
  end
  
  resources :users, :only => [:show] 
  
  resources :beers # :except => [:update] :only => [ :index, :new, :create, :edit, :update ]
  match "beers/:id" => 'beers#update', :via => :post
  resources :ratings, :only => [ :create, :edit, :update ]
  get "my_beers" => "beers#my_beers"

  resources :pages
  root :to => "beers#index"
  

  
end
