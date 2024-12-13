Rails.application.routes.draw do
  get "/posts/me", to: "posts#me", as: :current_user_posts
  resources :posts, param: :slug do
    resources :comments, only: [ :create, :edit, :update, :destroy ] do
      resources :replies, only: [ :create ]
    end
  end

  # devise_for :users
  devise_for :users,
    path: "auth",
    path_names: {
      sign_in: "login", sign_out: "logout",
      password: "secret", confirmation: "verification",
      unlock: "unblock", registration: "register", sign_up: "sign_up"
    },
    controllers: { registrations: "users/registrations" }

  post "/follow/:user_id", to: "users/followers#follow", as: :follow_user
  delete "/unfollow/:user_id", to: "users/followers#unfollow", as: :unfollow_user

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
end
