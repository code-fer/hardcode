Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "pages/home"

  #ruta logout
  resources :retos, only: [:index, :new, :create, :show]
  #get "login", to: "login#new"    # Ruta para mostrar el formulario del login
  get 'sign_out', to: 'sessions#destroy', as: :sign_out

  get "logout", to: "login#destroy" # cerrar sesión
  get "register", to: "home#register", as: "register"
  # registro de datos usuario (competidor)
  get "userdata", to: "userdata#new", as: "userdata"
  post "userdata", to: "userdata#createcompetidor"

  # registro de creador
  get "register_creator", to: "register#new", defaults: { type: "creator" }
  post "registercreator/competidor", to: "register#createcreador"

  # registro de empresas
  get "registerenterprise", to: "home#registerenterprise", as: "registerenterprise"
  # pantallas administrador
  get "adminaccounts", to: "home#adminaccounts", as: "adminaccounts"
  get "adminretos", to: "home#adminretos", as: "adminretos"
  get "admindenuncias", to: "home#admindenuncias", as: "admindenuncias"

  #rutas arena
  get "hardcodeArena", to: "arena#arena", as: "arena"

  # rutas perfilUser
  get "perfilUser", to: "perfil_users#user", as: "perfil_user"

  #rutas reto (display)
  get "reto/:id", to: "retos#show", as: "reto_show"

  # La ruta para subir una solución a un reto específico

  get 'new/:id', to: 'uploads#new', as: 'new_for_reto'
  post 'create/:id', to: 'uploads#create', as: 'create_for_reto'

  #para ver soluciones
  get "solucion/:solucion_id/:reto_id", to: "solucions#show", as: "solucion_reto"

  #para votar soluciones
   resources :votos, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
