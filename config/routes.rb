Rails.application.routes.draw do
  resources :despachos
  resources :tiempos_de_entregas
  resources :pedidos
  resources :lineas_de_impresiones
  resources :contactos
  resources :clientes
  devise_for :users
  resources :users
  resources :roles
 
  get 'produccion', to: 'pedidos#produccion', as: :produccion
  root :to => 'static_pages#home'
  
  resources :contactos, :only => :none do
   
      get :vista
    
  end

  
  
end
