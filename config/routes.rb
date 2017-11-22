Rails.application.routes.draw do
  resources :contactos
  resources :clientes
  devise_for :users
  resources :users
  resources :roles
 
  root :to => 'static_pages#home'
  
  
end
