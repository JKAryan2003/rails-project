Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "landing#index"

  resources :users do
    member do
      get '/post', to: 'users#user_post'
    end
    collection do
      get '/menu' ,to: 'users#menu'
    end
  end

  resources :roles 
  resources :confirmation, only: [:edit]
  
  resources :posts do
    resources :comments, only: [:create]
  end

  get '/signup', to: 'registrations#new'
	post '/signup', to: 'registrations#create', as: :qwerty
	delete '/signup', to: 'registrations#destroy'



	get '/login', to: 'sessions#new', as: :login_path
	post '/login', to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'


end
