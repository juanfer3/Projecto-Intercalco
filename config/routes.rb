Rails.application.routes.draw do
  resources :tiempos_de_entregas
  resources :pedidos
  resources :facturas
  resources :despachos
  resources :lineas_de_impresiones
  resources :contactos
  resources :clientes
  devise_for :users
  resources :users
  resources :roles
 
  root :to => 'static_pages#home'
  
  
end
