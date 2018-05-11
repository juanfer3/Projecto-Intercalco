class CompromisoDeEntrega < ApplicationRecord
  belongs_to :orden_produccion

  after_update  :cerrar



  def self.buscador_de_ordenes(data)

  end

  def self.execute_sql(*sql)
    connection.execute(send(:sanitize_sql_array, sql))
  end




  def self.generador_informe_de_pendientes_por_facturar
    facturado = true
    sql = "SELECT
    ordenes_produccion.cantidad_solicitada,
    ordenes_produccion.fecha,
    ordenes_produccion.precio_unitario,
    ordenes_produccion.numero_de_orden as OrdenProduccion,
    montajes.nombre as Montaje,
    compromisos_de_entrega.* as CompromisoDeEntrega,
    lineas_productos.nombre as LineaProducto,
    users.nombre as User,
    clientes.nombre as Cliente
    FROM ordenes_produccion
    inner join montajes on ordenes_produccion.montaje_id = montajes.id
    inner join clientes on montajes.cliente_id = clientes.id
    inner join compromisos_de_entrega on compromisos_de_entrega.orden_produccion_id = ordenes_produccion.id
    inner join lineas_productos on montajes.linea_producto_id = lineas_productos.id
    inner join users on clientes.user_id = users.id
    where
    ordenes_produccion.facturado != ?
    ;
    "
    datos = CompromisoDeEntrega.execute_sql(sql, facturado)


    return datos
  end



  def self.generar_busqueda_de_informe_oportunidad(fecha_inicial, fecha_final, linea_producto_id)



      sql = "SELECT
      ordenes_produccion.cantidad_solicitada,
      ordenes_produccion.fecha,
      ordenes_produccion.numero_de_orden as OrdenProduccion,
      montajes.nombre as Montaje,
      compromisos_de_entrega.* as CompromisoDeEntrega,
      lineas_productos.nombre as LineaProducto,
      clientes.nombre as Cliente
      FROM ordenes_produccion
      inner join montajes on ordenes_produccion.montaje_id = montajes.id
      inner join clientes on montajes.cliente_id = clientes.id
      inner join compromisos_de_entrega on compromisos_de_entrega.orden_produccion_id = ordenes_produccion.id
      inner join lineas_productos on montajes.linea_producto_id = lineas_productos.id
      where
      compromisos_de_entrega.fecha_despacho BETWEEN ? AND ? AND lineas_productos.id = ?
      ;
      "
      datos = CompromisoDeEntrega.execute_sql(sql,fecha_inicial.to_date.strftime("%Y-%m-%d"),fecha_final.to_date.strftime("%Y-%m-%d"),  linea_producto_id)


      return datos

  end


def self.generar_busqueda_de_informe_oportunidad_de_todas_las_lineas(fecha_inicial, fecha_final)

  sql = "SELECT
  ordenes_produccion.cantidad_solicitada,
  ordenes_produccion.fecha,
  ordenes_produccion.numero_de_orden as OrdenProduccion,
  montajes.nombre as Montaje,
  compromisos_de_entrega.* as CompromisoDeEntrega,
  lineas_productos.nombre as LineaProducto,
  clientes.nombre as Cliente
  FROM ordenes_produccion
  inner join montajes on ordenes_produccion.montaje_id = montajes.id
  inner join clientes on montajes.cliente_id = clientes.id
  inner join compromisos_de_entrega on compromisos_de_entrega.orden_produccion_id = ordenes_produccion.id
  inner join lineas_productos on montajes.linea_producto_id = lineas_productos.id
  where
  compromisos_de_entrega.fecha_despacho BETWEEN ? AND ?
  ;
  "
  datos = CompromisoDeEntrega.execute_sql(sql,fecha_inicial.to_date.strftime("%Y-%m-%d"),fecha_final.to_date.strftime("%Y-%m-%d"))


  return datos

end


  def self.generador_informe_de_oportunidad(fecha_inicial, fecha_final, linea_producto_id)
    puts"===START CONSULTA DE FECHA===".green
    datos = []
    datos = CompromisoDeEntrega.generar_busqueda_de_informe_oportunidad(fecha_inicial, fecha_final, linea_producto_id)
    datos.each do |d|
      puts"#{d}".red
    end
    return datos
  end



  def self.generador_informe_de_oportunidad_todas_las_lineas(fecha_inicial, fecha_final)
    puts"===START CONSULTA DE FECHA===".green
    datos = []
    datos = CompromisoDeEntrega.generar_busqueda_de_informe_oportunidad_de_todas_las_lineas(fecha_inicial, fecha_final)
    datos.each do |d|
      puts"#{d}".red
    end
    return datos
  end


  def cerrar()

    puts "****************************************Edicion A LA ORdes De PRoduccion "+self.orden_produccion_id.to_s+"***********************************+"
    @envios = CompromisoDeEntrega.where("orden_produccion_id='#{self.orden_produccion_id}'")
    @orden = OrdenProduccion.find_by(id: self.orden_produccion_id)
    if @envios == nil
        puts"*********************************************Busqueda Nula***********************************************"
    else
      cont=0
      tam_length = @envios.length
        @envios.each do  |envio|
          if envio.enviado== true
            cont = cont + 1

          end
        end
        if cont == tam_length
          puts "**************************SE puede Cerrar**************"
        @orden.update(entregado:true)


              puts "**************************Cambio exitoso  #{@orden.entregado}**************"

        else
          puts "**************************NO SE puede Cerrar**************"
          if @orden.entregado == true
            @orden.update(entregado:false)

          end
        end

    end

  end
end
