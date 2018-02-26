Rails.application.routes.draw do
  get 'braintree/new'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  root "welcome#index"
  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :listings do
    resources :bookings
  end

  get "/users/current_user/bookings" => "bookings#user_bookings", as: "user_bookings"
  get "/users/:user_id/listings" => "listings#user_listings", as: "user_listings"

  get "/listings/:listing_id/bookings/:id/new_payment" => "bookings#pay", as: "new_payment"
  post '/listings/:listing_id/bookings/:id/submit_payment'=> "bookings#submit_payment", as: "submit_payment"


  # get "/welcome" => "welcome#index", as: "welcome"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
