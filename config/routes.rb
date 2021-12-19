Rails.application.routes.draw do
  get '/', to: 'home#index'
  get '/users/logout', to: 'users#logout'
  get '/users/login', to: 'users#login'
  post '/users/login', to: 'users#login'

  get '/users/register', to: 'users#register'
  post '/users/register', to: 'users#register'

  resources :posts
  
end
