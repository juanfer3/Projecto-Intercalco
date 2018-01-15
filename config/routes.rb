Rails.application.routes.draw do
  resources :producciones_ordenes
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
  resources :montajes
  resources :piezas
  resources :maquinas

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
  get 'cambiar_estado_impresion/:id', to: 'pedidos#cambiar_estado_impresion', as: :cambiar_estado_impresion
  get 'cambiar_estado_troquel/:id', to: 'pedidos#cambiar_estado_troquel', as: :cambiar_estado_troquel
  get 'cambiar_estado_acabados/:id', to: 'pedidos#cambiar_estado_acabados', as: :cambiar_estado_acabados
  get 'cambiar_habilitar_impresion/:id', to: 'pedidos#cambiar_habilitar_impresion', as: :cambiar_habilitar_impresion
  get 'cambiar_habilitar_acabado/:id', to: 'pedidos#cambiar_habilitar_acabado', as: :cambiar_habilitar_acabado

  get 'despacho_facturas', to: 'tiempos_de_entregas#despacho_facturas', as: :despacho_facturas
  get 'info_despacho_facturas/:id', to: 'tiempos_de_entregas#info_despacho_facturas', as: :info_despacho_facturas
  get 'anexar_num_factura/:id', to: 'tiempos_de_entregas#anexar_num_factura', as: :anexar_num_factura
  get 'consultar_factura', to: 'tiempos_de_entregas#consultar_factura', as: :consultar_factura
  get 'anexar_tiempo_de_entrega', to: 'tiempos_de_entregas#anexar_tiempo_de_entrega', as: :anexar_tiempo_de_entrega
  get 'ver_factura/:id', to: 'tiempos_de_entregas#ver_factura', as: :ver_factura
  get 'cerrar_pedido/:id', to: 'tiempos_de_entregas#cerrar_pedido', as: :cerrar_pedido
  get 'ordenes', to: 'pedidos#ordenes', as: :ordenes

end
