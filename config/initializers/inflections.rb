ActiveSupport::Inflector.inflections(:en) do |inflect|

  inflect.irregular 'rol', 'roles'
  inflect.irregular 'cargo', 'cargos'
  inflect.irregular 'estado', 'estados'
  inflect.irregular 'nombre', 'nombres'
  inflect.irregular 'usuario', 'usuarios'
  inflect.irregular 'correo', 'correos'
  inflect.irregular 'user', 'users'
  inflect.irregular 'celular', 'celular'
  inflect.irregular 'cliente', 'clientes'
  inflect.irregular 'nit', 'nits'
  inflect.irregular 'nombre_contacto', 'nombres_contactos'
  inflect.irregular 'telefono', 'telefonos'
  inflect.irregular 'correo', 'correos'
  inflect.irregular 'direccion', 'direcciones'
  inflect.irregular 'contacto', 'contactos'

  inflect.irregular 'tamano', 'tamanos'
  inflect.irregular 'numero_pedido', 'numero_pedidos'
  inflect.irregular 'linea_de_impresion', 'lineas_de_impresiones'
  inflect.irregular 'tipo_de_linea', 'tipos_de_lineas'
  inflect.irregular 'tiempos_de_entrega', 'tiempos_de_entregas'
  inflect.irregular 'costo', 'costos'
  inflect.irregular 'fecha_compromiso', 'fechas_compromiso'
  inflect.irregular 'total_fechas_decompromiso','totales_fechas_decompromiso'

  inflect.irregular 'factura','facturas'
  inflect.irregular 'despacho', 'despachos'
  inflect.irregular 'lugar_a_factura','lugares_a_facturar'
  inflect.irregular 'recibe','reciben'

  inflect.irregular 'condicion_de_pedido','condiciones_de_pedido'
  inflect.irregular 'entregar_factura','entregar_facturas'

  inflect.irregular 'orden_de_produccion','ordenes_de_produccion'
  inflect.irregular 'fecha_final','fechas_finales'
  inflect.irregular 'fecha','fechas'
  inflect.irregular 'total','totales'
  inflect.irregular 'detalle_de_produccion','detalles_de_produccion'
  inflect.irregular 'inventario','inventarios'
  inflect.irregular 'numero_de_orden','numeros_de_ordenes'

  inflect.irregular 'codigo','codigos'
  inflect.irregular 'fecha','fechas'
  inflect.irregular 'cantidad','cantidades'

  inflect.irregular 'remision','remisiones'
  inflect.irregular 'fecha_de_despacho','fechas_de_despachos'
  inflect.irregular 'cantidad_enviada','cantidades_enviadas'
  inflect.irregular 'precio_a_facturar','precios_a_facturar'
  inflect.irregular 'cantidad_faltante','cantidades_faltantes'
  inflect.irregular 'anexo','anexos'
  inflect.irregular 'entrega_cumplida','entregas_cumplidas'

  inflect.irregular 'factura_despacho', 'facturas_despacho'
  inflect.irregular 'numero_de_factura', 'numeros_de_facturas'
  inflect.irregular 'cancelada', 'canceladas'
  inflect.irregular 'numero_de_remision', 'numeros_de_remisiones'
  inflect.irregular 'iva', 'ivas'
  inflect.irregular 'total_facturado', 'totales_facturados'
  inflect.irregular 'descuento', 'descuentos'

  inflect.irregular 'usuario_asignado', 'usuario_asignados'
  inflect.irregular 'habilitar_acabado', 'habilitar_acabados'
  inflect.irregular 'habilitar_impresion', 'habilitar_impresiones'

  inflect.irregular 'dimension', 'dimensiones'
  inflect.irregular 'dimension_1', 'dimensiones_1'
  inflect.irregular 'dimension_2', 'dimensiones_2'
  inflect.irregular 'numero_de_montaje', 'numero_de_montajes'
  inflect.irregular 'tipo_de_unidad', 'tipo_de_unidades'
  inflect.irregular 'pieza', 'piezas'
  inflect.irregular 'maquina', 'maquinas'
  inflect.irregular 'linea_producto', 'lineas_productos'

  inflect.irregular 'pieza_a_decorar', 'piezas_a_decorar'
  inflect.irregular 'produccion_orden', 'producciones_ordenes'
  inflect.irregular 'montaje','montajes'
  inflect.irregular 'cantidad_programada', 'cantidades_programadas'
  inflect.irregular 'precio_unitario', 'precios_unitarios'
  inflect.irregular 'valor_total', 'valores_totales'
  inflect.irregular 'tipo_de_produccion', 'tipos_de_producciones'
  inflect.irregular 'tamanos_total', 'tamanos_totales'
  inflect.irregular 'cavidad', 'cavidades'
  inflect.irregular 'cantidad_hoja', 'cantidades_hojas'
  inflect.irregular 'retiro', 'retiros'
  inflect.irregular 'modo_de_empaque', 'modos_de_empaques'
  inflect.irregular 'fecha_de_creacion', 'fechas_de_creacion'
  inflect.irregular 'material', 'materiales'
  inflect.irregular 'temperatura', 'temperaturas'
  inflect.irregular 'orden_produccion', 'ordenes_produccion'
  inflect.irregular 'dia', 'dias'
  inflect.irregular 'mes', 'meses'
  inflect.irregular 'formato_op', 'formatos_op'
  inflect.irregular 'linea_de_color', 'lineas_de_colores'

  inflect.irregular 'malla', 'mallas'
  inflect.irregular 'tinta_fop_tiro', 'tintas_fop_tiro'
  inflect.irregular 'tinta_fop_retiro', 'tintas_fop_retiro'
  inflect.irregular 'tipo_de_tinta', 'tipos_de_tintas'
  inflect.irregular 'color', 'colores'
  inflect.irregular 'tinta', 'tintas'
  inflect.irregular 'formulado', 'formulados'
  inflect.irregular 'tinta_formulada', 'tintas_formuladas'
  inflect.irregular 'pantone', 'pantones'
  inflect.irregular 'formula_tinta', 'formulas_tinta'
  inflect.irregular 'porcentaje', 'porcentajes'
  inflect.irregular 'montaje_tinta', 'montaje_tintas'
  inflect.irregular 'compromiso_de_entrega', 'compromisos_de_entrega'
  inflect.irregular 'fecha_de_compromiso', 'fechas_de_compromiso'
  inflect.irregular 'fecha_despacho', 'fechas_despachos'
  inflect.irregular 'cantidad_despacho', 'cantidades_despachos'
  inflect.irregular 'precio_despacho', 'precios_despachos'
  inflect.irregular 'diferencia', 'diferencias'
  inflect.irregular 'precio', 'precios'

  inflect.irregular 'tamano_hoja', 'tamanos_hojas'
  inflect.irregular 'tamano_por_hojas', 'tamano_por_hojas'
  inflect.irregular 'tamano_de_corte', 'tamanos_de_corte'
  inflect.irregular 'cantidad_hoja', 'cantidades_hojas'

  inflect.irregular 'precorte', 'precortes'
  inflect.irregular 'pretroquelado', 'pretroquelados'
  inflect.irregular 'laminado', 'laminados'
  inflect.irregular 'troquelado', 'troquelados'
  inflect.irregular 'descalerillado', 'descalerillados'
  inflect.irregular 'plotter', 'plotters'
  inflect.irregular 'doming', 'domings'
  inflect.irregular 'descolille', 'descolilles'
  inflect.irregular 'doblez_calor', 'dobleces_calor'
  inflect.irregular 'termoformado', 'termoformados'
  inflect.irregular 'estampado_al_calor', 'estampados_al_calor'
  inflect.irregular 'refilado', 'refilados'
  inflect.irregular 'perforado', 'perforados'
  inflect.irregular 'ojalete', 'ojaletes'
  inflect.irregular 'hilo', 'hilos'
  inflect.irregular 'pegado', 'pegados'
  inflect.irregular 'ensamblado', 'ensamblados'
  inflect.irregular 'otro', 'otros'
  inflect.irregular 'enviado', 'enviados'
  inflect.irregular 'cumplido', 'cumplidos'

  inflect.irregular 'desarrollo_de_tinta', 'desarrollos_de_tintas'
  inflect.irregular 'tinta_nueva', 'tintas_nuevas'
  inflect.irregular 'transicion', 'transiciones'

  inflect.irregular 'cantidad_solicitada', 'cantidades_solicitadas'

  inflect.irregular 'contenedor_de_ordenes', 'contenedores_de_ordenes'

  inflect.irregular 'medida_material', 'medidas_materiales'

  inflect.irregular 'facturar_a', 'facturarles_a'
  inflect.irregular 'orden_de_compra', 'ordenes_de_compras'
  inflect.irregular 'contenedor_de_maquinas', 'contenedores_de_maquinas'

  inflect.irregular 'nombre_facturacion', 'nombres_facturaciones'
  inflect.irregular 'lugar_despacho', 'lugares_despachos'

  inflect.irregular 'contenedor_de_acabados', 'contenedores_de_acabados'

  inflect.irregular 'orden_nueva', 'ordenes_nuevas'

  inflect.irregular 'formato_de_tamaño', 'formatos_de_tamaños'

  inflect.irregular 'habilitar_corte_de_material', 'habilitar_cortes_de_materiales'
  inflect.irregular 'sacar_de_inventario', 'sacar_de_inventarios'

  inflect.irregular 'unidad', 'unidades'

  inflect.irregular 'programacion_orden_por_maquina', 'programaciones_ordenes_por_maquinas'
  inflect.irregular 'total_hora', 'total_horas'
  inflect.irregular 'hora_inicio', 'horas_inicio'
  inflect.irregular 'hora_final', 'horas_final'
  inflect.irregular 'cantidad_maquinas', 'cantidades_maquinas'
  inflect.irregular 'tiempo_por_maquina', 'tiempos_por_maquinas'
  inflect.irregular 'tiempo_de_montaje', 'tiempos_de_montaje'
  inflect.irregular 'tiempo_de_desmontaje', 'tiempos_de_desmontaje'
  inflect.irregular 'habilitado', 'habilitados'
  inflect.irregular 'variable_estandar', 'variables_estandar'
  inflect.irregular 'complemento', 'complementos'
  inflect.irregular 'programacion_op_maquina', 'programaciones_op_maquinas'


  inflect.irregular 'tirajes_por_hora', 'tirajes_por_horas'
  inflect.irregular 'complemento', 'complementos'
  inflect.irregular 'fecha_de_impresion', 'fechas_de_impresion'
  inflect.irregular 'fecha_de_impresion_final', 'fechas_de_impresion_final'

  inflect.irregular 'facturado', 'facturados'

  inflect.irregular 'habilitar_preprensa', 'habilitar_preprensas'

  inflect.irregular 'administrador_maquina', 'administrador_maquinas'

  inflect.irregular 'proceso_maquinas', 'procesos_maquinas'


end
