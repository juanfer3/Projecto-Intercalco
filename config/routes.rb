Rails.application.routes.draw do
  resources :detalles_de_produccion
  resources :ordenes_de_produccion
  resources :despachos
  resources :tiempos_de_entregas
  resources :pedidos
  resources :lineas_de_impresiones
  resources :contactos
  resources :clientes
  devise_for :users
  resources :users
  resources :roles

  get 'produccion', to: 'ordenes_de_produccion#produccion', as: :produccion

  root :to => 'static_pages#home'

  get 'info_produccion', to: 'ordenes_de_produccion#info_produccion', as: :info_produccion

  post 'crearNuevaOrden', to: 'ordenes_de_produccion#crearNuevaOrden', as: :crearNuevaOrden

 # resources :ordenes_de_produccion, :only => :none do
#      get :info_produccion
#  end


  resources :contactos, :only => :none do
      get :vista
  end



end
