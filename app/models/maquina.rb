class Maquina < ApplicationRecord
  require 'colorize'


def self.change_datos_to_horas(data)

  hora = data.to_s.split(".")[0]
  min = data.to_s.split(".")[1]
  min = min.to_i * 60
  min = min
  min = min.to_s[0..1]

  #DATOS IMPRESOS
  puts"Data: #{data}".yellow
  puts"Hora: #{hora}".yellow
  puts"Min: #{min}".yellow

  total_hora = hora + ":" + min
  return total_hora
end

def self.programar_orden(programacion_op_maquina, cantidad_maquinas)
  #puts"======START DATOS======".yellow
  #puts"programacion_op_maquina.orden_produccion.tamanos_total".yellow
  #puts"programacion_op_maquina.tirajes_por_hora".yellow
  #puts"programacion_op_maquina.orden_produccion.montaje.desarrollos_de_tintas.length".yellow
  #puts"programacion_op_maquina.tiempo_de_montaje".yellow
  #puts"programacion_op_maquina.tiempo_de_desmontaje".yellow
  #puts"programacion_op_maquina.total_hora".yellow
  #puts"======END DATOS=====".yellow

  #TOMA DE DATOS
  tamanos_totales = programacion_op_maquina.orden_produccion.tamanos_total
  tirajes_por_hora = programacion_op_maquina.tirajes_por_hora
  num_tintas = programacion_op_maquina.orden_produccion.montaje.desarrollos_de_tintas.length
  t_montaje = programacion_op_maquina.tiempo_de_montaje
  t_desmontaje = programacion_op_maquina.tiempo_de_desmontaje
  fecha_inicial = programacion_op_maquina.fecha_de_impresion
  hora_inicial = programacion_op_maquina.hora_inicio
  complemento = programacion_op_maquina.complemento
  puts"complemento#{complemento}".yellow
#ALGORITMO MATEMATICO PARA CALCULAR EL TIEMPO TOTAL
  firts_data = tamanos_totales / tirajes_por_hora * num_tintas
  puts"1 = #{firts_data}".yellow
  seconds_data = t_montaje * num_tintas
  puts"2 = #{seconds_data}".yellow
  thirds_data = t_desmontaje * num_tintas
  puts"3 = #{thirds_data}".yellow
  hora = (firts_data + seconds_data + thirds_data) * complemento.to_f
  puts"#{hora}".blue

  hora_por_maquina = hora / cantidad_maquinas.to_f

  #PASAR A DE DATOS A NUMEROS
  hora_total_por_maquina = Maquina.change_datos_to_horas(hora_por_maquina)
  total_horas = Maquina.change_datos_to_horas(hora)

  puts"HORAS TOTALES: #{total_horas}".blue
  puts"CANTIDAD HORAS POR MAQUINAS: #{hora_total_por_maquina}".yellow

  #puts"hora inicial: #{hora_inicial.strftime("%H:%M:%S")}".green

  fecha_inicial_hora = fecha_inicial.to_s+ " " + hora_inicial.strftime("%H:%M:%S")
  fecha_inicial_hora = DateTime.parse(fecha_inicial_hora)


  sumar_hora = fecha_inicial_hora +  hora_total_por_maquina.split(":")[0].to_i.hour
  sumar_mins = sumar_hora + hora_total_por_maquina.split(":")[1].to_i.minute
  fecha_y_hora_final = sumar_mins
  #puts"Fecha inicial: #{fecha_inicial}".yellow
  puts"FECHA inicial: #{fecha_inicial_hora}".red
  puts"FECHA FINAL: #{fecha_y_hora_final.strftime("%d/%m/%y")}".blue
  fecha_final_a_imprimir = fecha_y_hora_final.strftime("%d/%m/%y")

  #INSERCION A BASE DE DATOS
  programacion_cambiada = ProgramacionOpMaquina
  .find_by(id:programacion_op_maquina.id)
  .update(cantidad_maquinas:cantidad_maquinas.to_i, total_hora:total_horas,
  tiempo_por_maquina:hora_total_por_maquina,fecha_de_impresion_final:fecha_y_hora_final,
  hora_final:fecha_y_hora_final)


  programacion_cambiada = ProgramacionOpMaquina
  .find_by(id:programacion_op_maquina.id)

    if programacion_cambiada == nil
      puts"progrmacion nula".red
    else

      puts"cambios generados #{}".green
    end


=begin
  :orden_produccion_id,
    :maquina_id, :total_hora, :hora_inicio, :hora_final, :cantidad_maquinas,
    :tiempo_por_maquina, :tiempo_de_montaje, :tiempo_de_desmontaje, :habilitado,
    :complemento,:tirajes_por_hora,:fecha_de_impresion, :fecha_de_impresion_final
=end
  return programacion_cambiada
end

def self.update_cantidad_maq_best_in_place(id_programacion,cantidad_maquinas)

  puts"START UPDATE CANTIDAD MAQUINA BEST IN PLACE".green
  programacion_op_maquina = ProgramacionOpMaquina.find_by(id:id_programacion)
  programacion_op_maquina = Maquina.programar_orden(programacion_op_maquina, cantidad_maquinas)
  return programacion_op_maquina

end





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

  def self.descargar_ordenes_programadas_por_maquina(maquina_id)



      sql = "SELECT
      DISTINCT ordenes_produccion.numero_de_orden,
      ordenes_produccion.numero_de_orden,
      ordenes_produccion.cantidad_solicitada,ordenes_produccion.tamanos_total
      as OrdenProduccion,
      montajes.nombre as Montaje,
      programaciones_op_maquinas.* as ProgramacionOpMaquina,
      contenedores_de_maquinas.id as ContenedorDeMaquinas,
      desarrollos_de_tintas.* as DesarrolloDeTinta,
      clientes.nombre as Cliente
      FROM ordenes_produccion
      inner join montajes on ordenes_produccion.montaje_id = montajes.id
      inner join clientes on montajes.cliente_id = clientes.id
      inner join contenedores_de_maquinas on contenedores_de_maquinas.montaje_id = montajes.id
      inner join programaciones_op_maquinas on programaciones_op_maquinas.orden_produccion_id = ordenes_produccion.id
      inner join desarrollos_de_tintas on desarrollos_de_tintas.montaje_id = montajes.id
      where contenedores_de_maquinas.maquina_id = ?;
      "
      ordenes_produccion = Maquina.execute_sql(sql,maquina_id)

      ordenes_produccion.each do |orden|

        puts"====esta son las ordenes -#{orden["montaje"]}-==="
      end




      return ordenes_produccion

  end

  def self.descargar_ordenes_sin_programar_por_maquina(maquina_id)



      sql = "SELECT
      DISTINCT ordenes_produccion.numero_de_orden,
      ordenes_produccion.numero_de_orden,
      ordenes_produccion.cantidad_solicitada,ordenes_produccion.tamanos_total
      as OrdenProduccion,
      montajes.nombre as Montaje,
      contenedores_de_maquinas.id as ContenedorDeMaquinas,
      clientes.nombre as Cliente
      FROM ordenes_produccion
      inner join montajes on ordenes_produccion.montaje_id = montajes.id
      inner join clientes on montajes.cliente_id = clientes.id
      inner join contenedores_de_maquinas on contenedores_de_maquinas.montaje_id = montajes.id
      where contenedores_de_maquinas.maquina_id = ?;
      "
      ordenes_produccion = Maquina.execute_sql(sql,maquina_id)

      ordenes_produccion.each do |orden|

        puts"====esta son las ordenes -#{orden["montaje"]}-==="
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
