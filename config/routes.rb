Rails.application.routes.draw do
  resources :tiempos_de_entregas
  resources :despachos
  resources :pedidos
  resources :lineas_de_impresiones
  resources :contactos
  resources :clientes
  devise_for :users
  resources :users
  resources :roles
 
  get 'produccion', to: 'pedidos#produccion'
  root :to => 'static_pages#home'
  
  
end
