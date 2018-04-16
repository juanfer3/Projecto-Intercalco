class Maquina < ApplicationRecord
  require 'colorize'

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
        .where("ordenes_produccion.numero_de_orden LIKE ?", data+"%")
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
      .where("clientes.nombre LIKE ?", "%"+data+"%")
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
      .where("montajes.nombre LIKE ?", "%"+data+"%")
      if orden.empty?
        puts "******************CONSULTA VACIA**********************".red
      else
        puts "******************CONSULTA LLENA**********************".green
      end
    return orden

  end

end





end
