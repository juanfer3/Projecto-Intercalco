Rails.application.routes.draw do
  resources :contenedores_de_acabados
  resources :acabados
  resources :lugares_despachos
  resources :nombres_facturaciones
  resources :contenedores_de_maquinas
  resources :linea_de_colores
  resources :materiales
  resources :contenedores_de_ordenes
  resources :contenedor_de_remisiones
  resources :facturas
  resources :transiciones
  resources :desarrollos_de_tintas
  resources :ordenes_produccion
  resources :compromisos_de_entrega
  resources :tintas_fop_retiro
  resources :tintas_fop_tiro
  resources :formulas_tinta
  resources :tintas_formuladas
  resources :tintas
  resources :mallas
  resources :formatos_op
  resources :formato_ops
  resources :meses
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
  resources :lineas_productos
  resources :lineas_de_colores
  resources :piezas_a_decorar


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

  get 'cambiar_proceso/:id', to: 'ordenes_produccion#cambiar_proceso', as: :cambiar_proceso
  get 'cambiar_estado_pantalla/:id', to: 'ordenes_produccion#cambiar_estado_pantalla', as: :cambiar_estado_pantalla
  get 'cambiar_estado_color/:id', to: 'ordenes_produccion#cambiar_estado_color', as: :cambiar_estado_color
  get 'cambiar_estado_corte_material/:id', to: 'ordenes_produccion#cambiar_estado_corte_material', as: :cambiar_estado_corte_material
  get 'cambiar_estado_impresion/:id', to: 'ordenes_produccion#cambiar_estado_impresion', as: :cambiar_estado_impresion
  get 'cambiar_estado_troquel/:id', to: 'ordenes_produccion#cambiar_estado_troquel', as: :cambiar_estado_troquel
  get 'cambiar_estado_acabados/:id', to: 'ordenes_produccion#cambiar_estado_acabados', as: :cambiar_estado_acabados
  get 'cambiar_habilitar_impresion/:id', to: 'ordenes_produccion#cambiar_habilitar_impresion', as: :cambiar_habilitar_impresion
  get 'cambiar_habilitar_acabado/:id', to: 'ordenes_produccion#cambiar_habilitar_acabado', as: :cambiar_habilitar_acabado

  get 'despacho_facturas', to: 'tiempos_de_entregas#despacho_facturas', as: :despacho_facturas
  get 'info_despacho_facturas/:id', to: 'tiempos_de_entregas#info_despacho_facturas', as: :info_despacho_facturas
  get 'anexar_num_factura/:id', to: 'tiempos_de_entregas#anexar_num_factura', as: :anexar_num_factura
  get 'consultar_factura', to: 'tiempos_de_entregas#consultar_factura', as: :consultar_factura
  get 'anexar_tiempo_de_entrega', to: 'tiempos_de_entregas#anexar_tiempo_de_entrega', as: :anexar_tiempo_de_entrega
  get 'ver_factura/:id', to: 'tiempos_de_entregas#ver_factura', as: :ver_factura
  get 'cerrar_pedido/:id', to: 'tiempos_de_entregas#cerrar_pedido', as: :cerrar_pedido
  get 'ordenes', to: 'pedidos#ordenes', as: :ordenes

  get 'buscar_fop/:id', to: 'montajes#buscar_fop', as: :buscar_fop

  get 'cargar_form_formato', to: 'ordenes_produccion#cargar_form_formato', as: :cargar_form_formato

  get 'cargar_form', to: 'ordenes_produccion#cargar_form', as: :cargar_form

  post 'import_fop_from_excel' => "formatos_op#import_fop_from_excel", as: :import_fop_from_excel

  post 'import_montaje_from_excel' => "montajes#import_montaje_from_excel", as: :import_montaje_from_excel


  post 'import__MP_from_excel' => "montajes#import__MP_from_excel", as: :import__MP_from_excel

  post 'import_tintas_from_excel' => "tintas#import_tintas_from_excel", as: :import_tintas_from_excel

  post 'import_tintas_formuladas_from_excel' => "tintas_formuladas#import_tintas_formuladas_from_excel", as: :import_tintas_formuladas_from_excel

  post 'import_formulaTintas_from_excel' => "formulas_tinta#import_formulaTintas_from_excel", as: :import_formulaTintas_from_excel

  post 'import_ordenes_produccion_from_excel' => "ordenes_produccion#import_ordenes_produccion_from_excel", as: :import_ordenes_produccion_from_excel

  get 'busquedaTintas', to: 'formulas_tinta#busquedaTintas', as: :busquedaTintas

  get 'busquedaTintasMontaje/:id', to: 'montajes#busquedaTintasMontaje', as: :busquedaTintasMontaje

  get 'select_buscar_montaje/:id', to: 'ordenes_produccion#select_buscar_montaje', as: :select_buscar_montaje

  get 'deshacer_envio/:id', to: 'compromisos_de_entrega#deshacer_envio', as: :deshacer_envio

  get 'produccion_pantallas', to: 'ordenes_produccion#produccion_pantallas', as: :produccion_pantallas
  get 'info_pantallas/:id', to: 'ordenes_produccion#info_pantallas', as: :info_pantallas
  get 'cerrar_pantalla/:id', to: 'ordenes_produccion#cerrar_pantalla', as: :cerrar_pantalla


  get 'produccion_coordinador', to: 'ordenes_produccion#produccion_coordinador', as: :produccion_coordinador
  get 'info_coordinador/:id', to: 'ordenes_produccion#info_coordinador', as: :info_coordinador
  get 'cerrar_materiales/:id', to: 'ordenes_produccion#cerrar_materiales', as: :cerrar_materiales


  get 'produccion_color', to: 'ordenes_produccion#produccion_color', as: :produccion_color
  get 'info_color/:id', to: 'ordenes_produccion#info_color', as: :info_color
  get 'cerrar_color/:id', to: 'ordenes_produccion#cerrar_color', as: :cerrar_color
  get 'info_factura/:id', to: 'facturas#info_factura', as: :info_factura

  get 'tintas_select/:id', to: 'montajes#tintas_select', as: :tintas_select


  get 'desarrollar_color/:id', to: 'ordenes_produccion#desarrollar_color', as: :desarrollar_color

  get 'crear_color/:id', to: 'tintas_formuladas#crear_color', as: :crear_color

  get 'desarrollar_tintas_tiro/:id', to: 'ordenes_produccion#desarrollar_tintas_tiro', as: :desarrollar_tintas_tiro

  get 'desarrollar_tintas_retiro/:id', to: 'ordenes_produccion#desarrollar_tintas_retiro', as: :desarrollar_tintas_retiro
  get 'desarrollar_factura/:id', to: 'facturas#desarrollar_factura', as: :desarrollar_factura

  get 'form_ordenes', to: 'montajes#form_ordenes', as: :form_ordenes


  get 'buscador_de_ordenes', to: 'ordenes_produccion#buscador_de_ordenes', as: :buscador_de_ordenes

  post 'buscador_de_ordenes_por_mes', to: 'ordenes_produccion#buscador_de_ordenes_por_mes', as: :buscador_de_ordenes_por_mes
  post 'buscador_de_ordenes_por_fecha', to: 'ordenes_produccion#buscador_de_ordenes_por_fecha', as: :buscador_de_ordenes_por_fecha

  post 'busquda_avanzada_produccion', to: 'ordenes_produccion#busquda_avanzada_produccion', as: :busquda_avanzada_produccion
  get 'cargar_select_advance_search', to: 'ordenes_produccion#cargar_select_advance_search', as: :cargar_select_advance_search

  get 'buscador_de_ordenes_despachos', to: 'compromisos_de_entrega#buscador_de_ordenes_despachos', as: :buscador_de_ordenes_despachos

  get 'buscador_de_fichas', to: 'montajes#buscador_de_fichas', as: :buscador_de_fichas

  get 'buscador_de_tintas', to: 'tintas#buscador_de_tintas', as: :buscador_de_tintas

  get 'buscador_de_tintas_formuladas', to: 'tintas_formuladas#buscador_de_tintas_formuladas', as: :buscador_de_tintas_formuladas

  post 'import_materiales_excel' => "materiales#import_materiales_excel", as: :import_materiales_excel

  get 'contactos_for_select/:id', to: 'montajes#contactos_for_select', as: :contactos_for_select

  get 'reporte_tinta/:id', to: 'ordenes_produccion#reporte_tinta', as: :reporte_tinta
  get 'open_modal_import', to: 'ordenes_produccion#open_modal_import', as: :open_modal_import

  get 'produccion_por_maquinas', to: 'maquinas#produccion_por_maquinas', as: :produccion_por_maquinas
  get 'consulta_por_maquinas/:id', to: 'maquinas#consulta_por_maquinas', as: :consulta_por_maquinas

end
