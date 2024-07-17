Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'my_registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles # , only: [:show, :index, :new, :create, :edit, :update] #Creates the route needed
  resources :users, only: %i[index show]
  resources :categories, except: [:destroy]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  resources :users, only: %i[index show]
  get 'upload_pic', to: 'users#upload_pic_get'
  post 'upload_pic_post', to: 'users#upload_pic_post'

  # Defines the root path route ("/")
  # root "posts#index"
end

#  get "/articles", to: "articles#index"  #The route above declares that GET /articles requests are mapped to the index
#   action of ArticlesController.

# resources :articles, only: [:show]
