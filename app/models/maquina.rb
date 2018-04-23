class Maquina < ApplicationRecord
  require 'colorize'

  def self.to_csv(production)

    CSV.generate do |csv|
      csv << column_names
      all.each do |orden|
        csv << orden.attributes.values_at(*column_names)
      end
    end

  end

  def self.execute_sql(*sql)
    connection.execute(send(:sanitize_sql_array, sql))
  end

  def self.descargar_ordenes_por_maquina(maquina_id)



      sql = "SELECT ordenes_produccion.numero_de_orden,
      ordenes_produccion.cantidad_solicitada,ordenes_produccion.tamanos_total
      as OrdenProduccion,
      montajes.nombre as Montaje,
      programaciones_op_maquinas.* as ProgramacionOpMaquina,
      contenedores_de_maquinas.id as ContenedorDeMaquinas,
      clientes.nombre as Cliente
      FROM ordenes_produccion
      inner join montajes on ordenes_produccion.montaje_id = montajes.id
      inner join clientes on montajes.cliente_id = clientes.id
      inner join contenedores_de_maquinas on contenedores_de_maquinas.montaje_id = montajes.id
      inner join programaciones_op_maquinas on programaciones_op_maquinas.orden_produccion_id = ordenes_produccion.id
      where contenedores_de_maquinas.maquina_id = ?;
      "
      ordenes_produccion = Maquina.execute_sql(sql,maquina_id)
      cont = 0
      ordenes_produccion.each do |orden|
        cont += 1
        puts"====esta son las ordenes#{orden.ordenes_produccion.numero_de_orden}==="
      end
      return ordenes_produccion

  end



  def self.buscador_de_ordenes_por_maquina(data)
    #code
    puts "****************BUSCADOR #{data}************************".red
    orden = []
    orden = Maquina.buscar_orden_por_numero_de_orden(data)



    if orden.empty?
              puts "*******************numero orden op vacio #{}*********************".red
              orden = Maquina.buscar_por_orden_por_cliente(data)

              if orden.empty?
                puts "*******************array vacio #{}*********************".red
                orden = Maquina.buscar_orden_por_montaje(data)


                              if orden.empty?
                                puts "****************MONTAJE NO EXISTE************************".red
                                return orden
                              else
                                puts "****************MONTAJE LLENO************************".green
                                return orden
                              end


              else
                puts "*******************cliente lleno*********************".green
                return orden
              end



   else
              puts "*******************numero de orden lleno*********************".green
              return orden
    end



    return orden
  end

#BUSCAR POR NUMERO DE ORDEN
  def self.buscar_orden_por_numero_de_orden(data)
    #code
    orden = []

    if data.length <= 0
      puts "******************LA DATA ESTA VACIA**********************".red
      return  orden

    else
      puts "******************LA DATA ESTA LLENA**********************".green
      orden = OrdenProduccion.joins(:montaje => [:cliente => [], :linea_producto => [],
        :material => []], :contacto => [], :nombre_facturacion => [])
        .where("ordenes_produccion.numero_de_orden ILIKE ?", data+"%")
        if orden.empty?
          puts "******************CONSULTA VACIA**********************".red
        else
          puts "******************CONSULTA LLENA**********************".green
        end
      return orden

    end

  end



#BUSCAR POR CLIENTE
def self.buscar_por_orden_por_cliente(data)
  #code
  orden = []

  if data.length <= 0
    puts "******************LA DATA ESTA VACIA**********************".red
    return  orden

  else
    puts "******************LA DATA ESTA LLENA**********************".green
    orden = OrdenProduccion.joins(:montaje => [:cliente => [], :linea_producto => [],
      :material => []], :contacto => [], :nombre_facturacion => [])
      .where("clientes.nombre ILIKE ?", "%"+data+"%")
      if orden.empty?
        puts "******************CONSULTA VACIA**********************".red
      else
        puts "******************CONSULTA LLENA**********************".green
      end
    return orden

  end

end


#BUSCAR POR MONTAJE
def self.buscar_orden_por_montaje(data)
  #code
  orden = []

  if data.length <= 0
    puts "******************LA DATA ESTA VACIA**********************".red
    return  orden

  else
    puts "******************LA DATA ESTA LLENA**********************".green
    orden = OrdenProduccion.joins(:montaje => [:cliente => [], :linea_producto => [],
      :material => []], :contacto => [], :nombre_facturacion => [])
      .where("montajes.nombre ILIKE ?", "%"+data+"%")
      if orden.empty?
        puts "******************CONSULTA VACIA**********************".red
      else
        puts "******************CONSULTA LLENA**********************".green
      end
    return orden

  end

end




end
