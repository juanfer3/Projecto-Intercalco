Rails.application.routes.draw do
  resources :remisiones
  resources :facturas_despacho
  resources :tiempos_de_entregas
  resources :ordenes_de_produccion
  resources :despachos
  resources :pedidos
  resources :lineas_de_impresiones
  resources :contactos
  resources :clientes
  devise_for :users
  resources :users
  resources :roles

  get 'produccion', to: 'pedidos#produccion', as: :produccion

  get 'entregas', to: 'pedidos#entregas', as: :entregas

  root :to => 'static_pages#home'

  get 'info_produccion', to: 'ordenes_de_produccion#info_produccion', as: :info_produccion

  post 'crearNuevaOrden', to: 'ordenes_de_produccion#crearNuevaOrden', as: :crearNuevaOrden

  get 'consultar_despacho/:id', to: 'pedidos#consultar_despacho', as: :consultar_despacho

  get 'info_despacho/:id', to: 'tiempos_de_entregas#info_despacho', as: :info_despacho

  get 'cambiar_estado/:id', to: 'pedidos#cambiar_estado', as: :cambiar_estado

  get 'cambiar_estado_a_Pedido/:id', to: 'pedidos#cambiar_estado_a_Pedido', as: :cambiar_estado_a_Pedido

  get 'genera_reporte_pedido', to: 'pedidos#genera_reporte_pedido', as: :genera_reporte_pedido


# resources :ordenes_de_produccion, :only => :none do
#      get :info_produccion
#  end


  resources :contactos, :only => :none do
      get :vista
  end

  post 'import_from_excel' => "clientes#import_from_excel"
  get 'vista_subir_excel', to: 'clientes#vista_subir_excel'
  post 'import_contactos_from_excel/:id' => "clientes#import_contactos_from_excel", as: :import_contactos_from_excel
  get 'contactos_subir_excel', to: 'clientes#contactos_subir_excel'

  get 'cambiar_proceso/:id', to: 'pedidos#cambiar_proceso', as: :cambiar_proceso
  get 'cambiar_estado_pantalla/:id', to: 'pedidos#cambiar_estado_pantalla', as: :cambiar_estado_pantalla
  get 'cambiar_estado_color/:id', to: 'pedidos#cambiar_estado_color', as: :cambiar_estado_color
  get 'cambiar_estado_corte_material/:id', to: 'pedidos#cambiar_estado_corte_material', as: :cambiar_estado_corte_material
  get 'cambiar_estado_impresion/:id', to: 'pedidos#cambiar_estado_corte_material', as: :cambiar_estado_corte_material
  get 'cambiar_estado_troquel/:id', to: 'pedidos#cambiar_estado_troquel', as: :cambiar_estado_troquel
  get 'cambiar_estado_acabados/:id', to: 'pedidos#cambiar_estado_acabados', as: :cambiar_estado_acabados

end
