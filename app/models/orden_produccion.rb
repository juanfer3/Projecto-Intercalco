class OrdenProduccion < ApplicationRecord
  require 'colorize'

  belongs_to :montaje
  belongs_to :contacto
  belongs_to :lugar_despacho
  belongs_to :nombre_facturacion


  has_many :compromisos_de_entrega, inverse_of: :orden_produccion, dependent: :destroy
  accepts_nested_attributes_for :compromisos_de_entrega, reject_if: :all_blank, allow_destroy: true



  attr_accessor :buscar, :contenedor_prueba, :contacto_nuevo, :tomar_cliente,
  :tomar_usuario, :direccion_nueva, :facturar_a_nuevo, :deshabilitar_por_linea


  before_save :antes_de_salvar
  after_create :despues_de_crear


  def despues_de_crear
    #code
    puts "==========================================================".blue
    puts "*******************HABILTAR IMPRESION*******************".green
    self.habilitar_impresion = false if sacar_de_inventario == true
    puts "==========================================================".blue
    puts "=*******************HABILTAR CORTE***********************=".green
    self.habilitar_corte_de_material = false if sacar_de_inventario == true
    puts "==========================================================".blue


    puts "==========================================================".blue
    puts "*******************DESHABILTAR IMPRESION*******************".green
    self.habilitar_impresion = true if sacar_de_inventario == false
    puts "==========================================================".blue
    puts "=*******************DESHABILTAR CORTE***********************=".green
    self.habilitar_corte_de_material = true if sacar_de_inventario == false
    puts "==========================================================".blue
  end

  def antes_de_salvar

    linea = self.montaje.linea_producto.nombre.upcase

    if linea == "DIGITAL"
      puts "*******************EL TRABAJO ES DIGTAL #{self.montaje.linea_producto.nombre}*********************".green
      self.habilitar_impresion = false
    end

    if facturar_a_nuevo.present?
      self.nombre_facturacion = NombreFacturacion.create(nombre: facturar_a_nuevo,  cliente_id:tomar_cliente)
      if self.nombre_facturacion
        puts "*******************Registro Facturar a Creado*********************"
      end
    end

    if direccion_nueva.present?
      self.lugar_despacho = LugarDespacho.create(cliente_id: tomar_cliente, direccion: direccion_nueva)
      if self.lugar_despacho
        puts "*******************Registro Despacho Creado*********************"
      end
    end

    self.contacto = Contacto.create(nombre_contacto: contacto_nuevo, user_id: tomar_usuario, cliente_id: tomar_cliente) if contacto_nuevo.present?
    if self.contacto.save
      puts "****************REGISTRO ALMACENADO************************"
    else
      puts "*******************FALLO EN LA INSERCION*********************"
    end
  end

def self.advanced_search_cliente_estado(estado,cliente)
  #code
  puts "****************ENTRA A BUSCAR SOLO POR CLIENTE - ESTADO************************".yellow
  orden = []
        case estado
          when "Impresión"
                      estado = true
                      inventario = false
                      acabado = false
                      orden =OrdenProduccion.joins(:montaje => [:cliente]).where("clientes.id = ? AND ordenes_produccion.impresion = ? AND ordenes_produccion.acabado = ? AND ordenes_produccion.sacar_de_inventario = ?",cliente, estado, acabado, inventario).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end

                      return orden
          when "Preprensa"
                      puts "*********************PREPRENSA*******************"
                      estado = true
                      impresion = false
                      orden =OrdenProduccion.joins(:montaje => [:cliente]).where("clientes.id = ? AND impresion = ? AND (color = ? OR  corte_material = ? OR pantalla = ?)",cliente, impresion, estado, estado, estado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
          when "Acabado"
                      estado = true
                      entregado = false
                      orden =OrdenProduccion.joins(:montaje => [:cliente]).where("clientes.id = ? AND acabado = ? AND entregado = ?",cliente, estado, entregado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
          when "Cerrado"
                    estado = true

                    orden =OrdenProduccion.joins(:montaje => [:cliente]).where("clientes.id = ? AND entregado = ?",cliente, estado).order("numero_de_orden DESC")
                    puts "***************Devuelve*************************"

                    if orden.empty?
                        puts "***********Produccion vacia no existe o no hay*****************************"
                    else
                        puts "***************Esta lleno*************************"
                    end
                    return orden
          when "Sin Programar"
                      estado = false
                      impresion = false
                      entregado = false
                      inventario = false
                      orden =OrdenProduccion.joins(:montaje => [:cliente]).where("clientes.id = ? AND color = ? AND  corte_material = ? AND pantalla = ? AND impresion = ? AND inventario= ? AND ENTREGADO = ?",cliente, estado, estado, estado, impresion, inventario,entregado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
        when "Inventario"
          puts "****************  START INVENTARIO  ************************".green
                    estado = true
                    acabado = false
                    entregado = false
                    orden =OrdenProduccion.joins(:montaje => [:cliente]).where("clientes.id = ? AND sacar_de_inventario = ? AND acabado = ? AND  entregado = ?",cliente, estado, acabado, entregado).order("numero_de_orden DESC")
                    puts "***************Devuelve*************************"

                    if orden.empty?
                        puts "***********Produccion vacia no existe o no hay*****************************"
                    else
                        puts "***************Esta lleno*************************"
                    end
          puts "*****************  END INVENTARIO  ***********************".green
                    return orden
        end


        return orden
end

def self.advanced_search_estado(data)
  #code
  puts "****************ENTRA A BUSCAR SOLO POR ESTADO************************".blue
  orden = []
        case data
          when "Impresión"
                      estado = true
                      acabado = false
                      orden =OrdenProduccion.where(impresion: estado, acabado: acabado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end

                      return orden
          when "Preprensa"
                      puts "*********************PREPRENSA*******************"
                      estado = true
                      impresion = false
                      entregado = false
                      orden =OrdenProduccion.where("impresion = ? AND entregado = ? AND (color = ? OR  corte_material = ? OR pantalla = ?)", impresion, entregado, estado, estado, estado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
          when "Acabado"
                      estado = true
                      entregado = false
                      orden =OrdenProduccion.where(" acabado = ? AND entregado = ?", estado, entregado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
          when "Cerrado"
                    estado = true

                    orden =OrdenProduccion.where("entregado = ?", estado).order("numero_de_orden DESC")
                    puts "***************Devuelve*************************"

                    if orden.empty?
                        puts "***********Produccion vacia no existe o no hay*****************************"
                    else
                        puts "***************Esta lleno*************************"
                    end
                    return orden
          when "Sin Programar"
                      estado = false
                      impresion = false
                      inventario = false
                      entregado = false
                      orden =OrdenProduccion.where("color = ? AND  corte_material = ? AND pantalla = ? AND impresion = ? AND sacar_de_inventario = ? AND ENTREGADO = ?", estado, estado, estado, impresion, inventario,entregado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
        when "Inventario"
          puts "****************  START INVENTARIO  ************************".green
                    estado = true
                    acabado = false
                    entregado = false
                    orden =OrdenProduccion.where("sacar_de_inventario = ? AND acabado = ? AND  entregado = ?", estado, acabado, entregado).order("numero_de_orden DESC")
                    puts "***************Devuelve*************************"

                    if orden.empty?
                        puts "***********Produccion vacia no existe o no hay*****************************"
                    else
                        puts "***************Esta lleno*************************"
                    end
          puts "*****************  END INVENTARIO  ***********************".green
                    return orden
        end


        return orden


end





def self.advanced_search_cliente(data, cliente)
  #code
  #code
  puts "****************ENTRA A BUSCAR ESTADO CON CLIENTE************************"
  orden = []
        case data
          when "Impresión"
                      estado = true
                      acabado = false
                      orden =OrdenProduccion.joins(:montaje => [:cliente]).where("clientes.nombre=? AND impresion = ? AND acabado", cliente,impresion,acabado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end

                      return orden
          when "Preprensa"
                      puts "*********************PREPRENSA*******************"
                      estado = true
                      impresion = false
                      orden =OrdenProduccion.where("impresion = ? AND (color = ? OR  corte_material = ? OR pantalla = ?)", impresion, estado, estado, estado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
          when "Acabado"
                      estado = true
                      entregado = false
                      orden =OrdenProduccion.where(" acabado = ? AND entregado = ?", estado, entregado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
          when "Cerrado"
            estado = true

            orden =OrdenProduccion.where("entregado = ?", estado).order("numero_de_orden DESC")
            puts "***************Devuelve*************************"

            if orden.empty?
                puts "***********Produccion vacia no existe o no hay*****************************"
            else
                puts "***************Esta lleno*************************"
            end
            return orden
          when "Sin Programar"
                      estado = false
                      impresion = false
                      entregado = false
                      orden =OrdenProduccion.where("color = ? AND  corte_material = ? AND pantalla = ? AND impresion = ? AND ENTREGADO = ?", estado, estado, estado, impresion, entregado).order("numero_de_orden DESC")
                      puts "***************Devuelve*************************"

                      if orden.empty?
                          puts "***********Produccion vacia no existe o no hay*****************************"
                      else
                          puts "***************Esta lleno*************************"
                      end
                      return orden
            when "Inventario"
              puts "****************  START INVENTARIO  ************************".green
                        estado = true
                        acabado = false
                        entregado = false
                        orden =OrdenProduccion.joins(:montaje => [:cliente]).where("clientes.id = ? AND sacar_de_inventario = ? AND acabado = ? AND  entregado = ?",cliente, estado, acabado, entregado).order("numero_de_orden DESC")
                        puts "***************Devuelve*************************"

                        if orden.empty?
                            puts "***********Produccion vacia no existe o no hay*****************************"
                        else
                            puts "***************Esta lleno*************************"
                        end
              puts "*****************  END INVENTARIO  ***********************".green
                        return orden
        end


        return orden


end

  def self.consultar_fecha(fecha)
    puts "****************la fecha es #{fecha}************************"
    fecha_de_compromiso=fecha.to_date
    ordenes = CompromisoDeEntrega.where(fecha_de_compromiso: fecha_de_compromiso)
    if ordenes.empty?
      puts "******************Vacio**********************"
    else
      puts "******************Lleno**********************"
    end

    return ordenes

  end





  def self.consultar_mes_cliente(mes, cliente)



    #code
    puts "*****************Consulta del mes: #{mes}***********************"

    case mes

          when "ENERO"
            numero_de_mes=1
            @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de enero vacio***********************"
            else
                puts "*****************ordendes del mes de enero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end
            return @ordenes

            end

          when "FEBRERO"
            numero_de_mes=2

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes

            end
          when "MARZO"
            numero_de_mes=3

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "ABRIL"
            numero_de_mes=4

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "MAYO"
            numero_de_mes=5

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end
          when "JUNIO"
            numero_de_mes=6

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end
          when "JULIO"
            numero_de_mes=7

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "AGOSTO"

            numero_de_mes=8

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "SEPTIEMBRE"
            numero_de_mes=9

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "OCTUBRE"
            numero_de_mes=10

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "NOVIEMBRE"
            numero_de_mes=11

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "DICIEMBRE"
            numero_de_mes=12

          @ordenes = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND extract(month from  fecha_de_compromiso) = ?", cliente, numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

    end



  end


  def self.buscador_estado_mes(mes,data)
    #code
    puts "*****************BUSCANDO MES Y ESTADO***********************".green
    orden = []
          case data
            when "Impresión"

                        acabado = false
                        impresion = true
                        orden =CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("extract(month from  compromisos_de_entrega.fecha_de_compromiso) = ? AND ordenes_produccion.impresion = ? AND ordenes_produccion.acabado = ?", mes,impresion,acabado).order("ordenes_produccion.numero_de_orden DESC")
                        puts "***************Devuelve*************************"

                        if orden.empty?
                            puts "***********Produccion vacia no existe o no hay*****************************"
                        else
                            puts "***************Esta lleno*************************"
                        end

                        return orden
            when "Preprensa"
                        puts "*********************PREPRENSA*******************"
                        estado = true
                        impresion = false
                        restos_de_estados = false
                        orden =CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("ordenes_produccion.impresion = ? AND (ordenes_produccion.color = ? OR  ordenes_produccion.corte_material = ? OR ordenes_produccion.pantalla = ?) AND extract(month from  compromisos_de_entrega.fecha_de_compromiso) = ? AND ordenes_produccion.sacar_de_inventario = ? AND ordenes_produccion.entregado = ? AND ordenes_produccion.impresion= ? AND ordenes_produccion.acabado=?", impresion, estado, estado, estado, mes, restos_de_estados, restos_de_estados, restos_de_estados, restos_de_estados).order("ordenes_produccion.numero_de_orden DESC")
                        puts "***************Devuelve*************************"

                        if orden.empty?
                            puts "***********Produccion vacia no existe o no hay*****************************"
                        else
                            puts "***************Esta lleno*************************"
                        end
                        return orden
            when "Acabado"
                        estado = true
                        entregado = false
                        orden =CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("extract(month from  compromisos_de_entrega.fecha_de_compromiso) = ? AND ordenes_produccion.acabado = ? AND ordenes_produccion.entregado = ?", mes, estado, entregado).order("ordenes_produccion.numero_de_orden DESC")
                        puts "***************Devuelve*************************"

                        if orden.empty?
                            puts "***********Produccion vacia no existe o no hay*****************************"
                        else
                            puts "***************Esta lleno*************************"
                        end
                        return orden
            when "Cerrado"
              estado = true

              orden =CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("extract(month from  compromisos_de_entrega.fecha_de_compromiso) = ? AND ordenes_produccion.entregado = ?", mes, estado).order("ordenes_produccion.numero_de_orden DESC")
              puts "***************Devuelve*************************"

              if orden.empty?
                  puts "***********Produccion vacia no existe o no hay*****************************"
              else
                  puts "***************Esta lleno*************************"
              end
              return orden
            when "Sin Programar"
                        estado = false
                        impresion = false
                        entregado = false
                        acabado = false
                        inventario = false
                        orden =CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("extract(month from  compromisos_de_entrega.fecha_de_compromiso) = ? AND ordenes_produccion.color = ? AND  ordenes_produccion.corte_material = ? AND ordenes_produccion.pantalla = ? AND ordenes_produccion.impresion = ? AND ordenes_produccion.ENTREGADO = ? AND ordenes_produccion.sacar_de_inventario = ? AND ordenes_produccion.Acabado = ?", mes, estado, estado, estado, impresion, entregado, inventario, acabado).order("ordenes_produccion.numero_de_orden DESC")
                        puts "***************Devuelve*************************"

                        if orden.empty?
                            puts "***********Produccion vacia no existe o no hay*****************************"
                        else
                            puts "***************Esta lleno*************************"
                        end
                        return orden
              when "Inventario"

                puts "****************  START INVENTARIO  ************************".green
                          estado = true
                          acabado = false
                          entregado = false
                          orden =CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("extract(month from  compromisos_de_entrega.fecha_de_compromiso) = ? AND ordenes_produccion.sacar_de_inventario = ? AND ordenes_produccion.acabado = ? AND  ordenes_produccion.entregado = ?", mes, estado, acabado, entregado).order("ordenes_produccion.numero_de_orden DESC")
                          puts "***************Devuelve*************************"

                          if orden.empty?
                              puts "***********Produccion vacia no existe o no hay*****************************"
                          else
                              puts "***************Esta lleno*************************"
                          end
                puts "*****************  END INVENTARIO  ***********************".green
                          return orden

          end


          return orden

  end


  #CONSULTAR POR MES Y ESTADO
  def self.consultar_mes_estado(mes, estado)

    puts "*****************Consulta del mes: #{mes}***********************"
    @ordenes = []
    case mes

          when "ENERO"
            numero_de_mes=1

            @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)

            if @ordenes.empty?
                puts "*****************ordendes del mes de enero vacio***********************"
            else
              puts "*****************ordendes del mes de febrero lleno***********************"
              @ordenes.each do |orden|
              puts "****************#{orden.orden_produccion.numero_de_orden}************************"
              end
            end
            return @ordenes



          when "FEBRERO"
            numero_de_mes=2

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


          when "MARZO"
            numero_de_mes=3

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de MARZO vacio***********************"
            else
                puts "*****************ordendes del mes de MARZO lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


          when "ABRIL"
            numero_de_mes=4

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


          when "MAYO"
            numero_de_mes=5

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes

          when "JUNIO"
            numero_de_mes=6

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes

          when "JULIO"
            numero_de_mes=7

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


          when "AGOSTO"

            numero_de_mes=8

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


          when "SEPTIEMBRE"
            numero_de_mes=9

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


          when "OCTUBRE"
            numero_de_mes=10

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


          when "NOVIEMBRE"
            numero_de_mes=11

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


          when "DICIEMBRE"
            numero_de_mes=12

          @ordenes = OrdenProduccion.buscador_estado_mes(numero_de_mes,estado)
            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
                end
            end

            return @ordenes


    end



  end








  # consulta por mes-cliente-estado
  def self.consultar_mes_cliente_estado(mes, cliente, estado)

      puts "********************CONSULTA MES CLIENTE Y ESTADO********************"
        #code
        puts "*****************Consulta del mes: #{mes}***********************"

        case mes

              when "ENERO"
                numero_de_mes=1

              when "FEBRERO"
                numero_de_mes=2

              when "MARZO"
                numero_de_mes=3

              when "ABRIL"
                numero_de_mes=4

              when "MAYO"
                numero_de_mes=5

              when "JUNIO"
                numero_de_mes=6

              when "JULIO"
                numero_de_mes=7

              when "AGOSTO"
                numero_de_mes=8

              when "SEPTIEMBRE"
                numero_de_mes=9

              when "OCTUBRE"
                numero_de_mes=10

              when "NOVIEMBRE"
                numero_de_mes=11

              when "DICIEMBRE"
                numero_de_mes=12
        end


#Consultar Por estados



          #code
          puts "****************ENTRA A BUSCAR SOLO POR CLIENTE - ESTADO************************".yellow
          orden = []
                case estado
                  when "Impresión"
                              estado = true
                              inventario = false
                              acabado = false

                              orden = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id =? AND ordenes_produccion.impresion = ? AND ordenes_produccion.acabado = ? AND ordenes_produccion.sacar_de_inventario = ? AND extract(month from  fecha_de_compromiso) = ?", cliente,estado, acabado, inventario, numero_de_mes).order("ordenes_produccion.numero_de_orden DESC")
                              puts "***************Devuelve*************************"

                              if orden.empty?
                                  puts "***********Produccion vacia no existe o no hay*****************************"
                              else
                                  puts "***************Esta lleno*************************"
                              end

                              return orden
                  when "Preprensa"
                              puts "*********************PREPRENSA*******************"
                              estado = true
                              impresion = false
                              orden =CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id = ? AND ordenes_produccion.impresion = ? AND color = ? AND  (ordenes_produccion.corte_material = ? OR ordenes_produccion.pantalla = ?) AND extract(month from  fecha_de_compromiso) = ?",cliente, impresion, estado, estado, estado,  numero_de_mes).order("ordenes_produccion.numero_de_orden DESC")
                              puts "***************Devuelve*************************"

                              if orden.empty?
                                  puts "***********Produccion vacia no existe o no hay*****************************"
                              else
                                  puts "***************Esta lleno*************************"
                              end
                              return orden
                  when "Acabado"
                              estado = true
                              entregado = false
                              orden = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id = ? AND ordenes_produccion.acabado = ? AND ordenes_produccion.entregado = ? AND extract(month from  fecha_de_compromiso) = ?",cliente, estado, entregado, numero_de_mes).order("ordenes_produccion.numero_de_orden DESC")
                              puts "***************Devuelve*************************"

                              if orden.empty?
                                  puts "***********Produccion vacia no existe o no hay*****************************"
                              else
                                  puts "***************Esta lleno*************************"
                              end
                              return orden
                  when "Cerrado"
                            estado = true

                            orden = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id = ? AND ordenes_produccion.entregado = ? AND extract(month from  fecha_de_compromiso) = ?",cliente, estado, numero_de_mes).order("ordenes_produccion.numero_de_orden DESC")
                            puts "***************Devuelve*************************"

                            if orden.empty?
                                puts "***********Produccion vacia no existe o no hay*****************************"
                            else
                                puts "***************Esta lleno*************************"
                            end
                            return orden
                  when "Sin Programar"
                              estado = false
                              impresion = false
                              entregado = false
                              inventario = false
                              orden = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id = ? AND ordenes_produccion.color = ? AND  ordenes_produccion.corte_material = ? AND ordenes_produccion.pantalla = ? AND ordenes_produccion.impresion = ? AND ordenes_produccion.entregado = ? AND ordenes_produccion.sacar_de_inventario = ?  AND extract(month from  fecha_de_compromiso) = ?",cliente, estado, estado, estado, impresion, entregado,inventario, numero_de_mes).order("ordenes_produccion.numero_de_orden DESC")
                              puts "***************Devuelve*************************"

                              if orden.empty?
                                  puts "***********Produccion vacia no existe o no hay*****************************"
                              else
                                  puts "***************Esta lleno*************************"
                              end
                              return orden
                when "Inventario"
                  puts "****************  START INVENTARIO  ************************".green
                            estado = true
                            acabado = false
                            entregado = false
                            orden = CompromisoDeEntrega.joins(:orden_produccion => [:montaje => [:cliente]]).where("clientes.id = ? AND ordenes_produccion.sacar_de_inventario = ? AND ordenes_produccion.acabado = ? AND  entregado = ? AND extract(month from  fecha_de_compromiso) = ?",cliente, estado, acabado, entregado, numero_de_mes).order("ordenes_produccion.numero_de_orden DESC")
                            puts "***************Devuelve*************************"

                            if orden.empty?
                                puts "***********Produccion vacia no existe o no hay*****************************"
                            else
                                puts "***************Esta lleno*************************"
                            end
                  puts "*****************  END INVENTARIO  ***********************".green
                            return orden
                end


                return orden








  end

  #consulta por mes
  def self.consultar_mes(mes)

    puts "*****************Consulta del mes: #{mes}***********************"

    case mes

          when "ENERO"
            numero_de_mes=1
            @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de enero vacio***********************"
            else
                puts "*****************ordendes del mes de enero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end
            return @ordenes

            end

          when "FEBRERO"
            numero_de_mes=2

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes

            end
          when "MARZO"
            numero_de_mes=3

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "ABRIL"
            numero_de_mes=4

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "MAYO"
            numero_de_mes=5

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end
          when "JUNIO"
            numero_de_mes=6

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end
          when "JULIO"
            numero_de_mes=7

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "AGOSTO"

            numero_de_mes=8

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "SEPTIEMBRE"
            numero_de_mes=9

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "OCTUBRE"
            numero_de_mes=10

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "NOVIEMBRE"
            numero_de_mes=11

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

          when "DICIEMBRE"
            numero_de_mes=12

          @ordenes = CompromisoDeEntrega.where("extract(month from  fecha_de_compromiso) = ?", numero_de_mes)

            if @ordenes.empty?
                puts "*****************ordendes del mes de febrero vacio***********************"
            else
                puts "*****************ordendes del mes de febrero lleno***********************"
                @ordenes.each do |orden|
                puts "****************#{orden.orden_produccion.numero_de_orden}************************"
            end

            return @ordenes
            end

    end
  end




  def self.subir_excel(file)
    @errores = []

    file_ext = File.extname(file.original_filename)
    raise "Unknown file type: #{file.original_filename}" unless [".xls", ".xlsx", ".csv"].include?(file_ext)

    if file_ext == ".xlsx"
      spreadsheet = Roo::Excelx.new(file.path)
    elsif file_ext == ".xls"
      spreadsheet = Roo::Excel.new(file.path)
    elsif file_ext == ".csv"
      spreadsheet = Roo::CSV.new(file.path)
    end

    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|
      puts "******************START ITERACION**********************".yellow

      vendedor = spreadsheet.row(i)[2].to_s.upcase


      puts "*****************#{vendedor}***********************"
      @vendedor= User.find_by(nombre: vendedor)

      if @vendedor != nil
        puts "****************El Vendedor Existe Star************************"

        numero_orden = spreadsheet.row(i)[0].to_s.upcase
        puts "****************Numer de Orden : #{numero_orden}************************"


            if numero_orden != ""

                          puts "****************la Orden no esta vacia***********************"
                          @ordenes = OrdenProduccion.find_by(numero_de_orden: numero_orden)
                          if @ordenes == nil
                            puts "****************la orden Existe #{numero_orden}***********************"

                          fecha_de_orden = spreadsheet.row(i)[4]
                          puts "**************Fecha de Orden: #{fecha_de_orden}**************************"

                          descripcion = spreadsheet.row(i)[8].to_s.upcase
                          @bus_montaje= Montaje.find_by(nombre:descripcion)
                          if @bus_montaje == nil


                                  puts "*********** El montaje NO existe*****************************"
                                  cliente =  spreadsheet.row(i)[7].to_s.upcase
                                  @bus_cliente= Cliente.find_by(nombre: cliente)


                                        if @bus_cliente == nil
                                                puts "***********El cliente NO existe*****************************"
                                                clienteNuevo=Cliente.new(nombre:cliente,user_id: @vendedor.id)

                                                if clienteNuevo.save
                                                  puts "***********El Cliente a sido Almacenado*****************************"
                                                  @cliente_id = clienteNuevo.id
                                                end
                                        else
                                                puts "***********El Cliente -SI- Existe*****************************"
                                                  @cliente_id = @bus_cliente.id
                                        end








                                        maquina =  spreadsheet.row(i)[19].to_s.upcase
                                        if maquina != ""
                                              @bus_maquina= Maquina.find_by(nombre: maquina)
                                              puts "**************Busqueda De la maquina**************************"


                                                        if @bus_maquina== nil
                                                          puts "**************La maquina es nula**************************"
                                                          maquinaNueva = Maquina.new(nombre: maquina)
                                                          if maquinaNueva.save
                                                              puts "**************La maquina a sido Creada**************************"
                                                              @maquina_id=maquinaNueva.id
                                                          end
                                                        else
                                                          puts "**************La maquina Existe**************************"
                                                            @maquina_id=@bus_maquina.id
                                                        end
                                        else
                                                puts "**************La El campo Pieza esta vacio**************************"
                                                busqueda="Por Definir"
                                                @bus_maquina= Maquina.find_by(nombre: busqueda)
                                                puts "**************Busqueda De la maquina nulas**************************"

                                                          busqueda="Por Definir"
                                                          if @bus_maquina== nil
                                                              maquinaNueva = Maquina.new(nombre: busqueda)
                                                              if maquinaNueva.save
                                                                  puts "**************La maquina a sido Creada y se Por Definir**************************"
                                                                  @maquina_id=maquinaNueva.id
                                                              end
                                                          else
                                                              @maquina_id=@bus_maquina.id
                                                          end
                                        end



                                        linea_color =  spreadsheet.row(i)[17].to_s.upcase
                                        if linea_color != ""
                                              @bus_linea_color= LineaDeColor.find_by(nombre: linea_color)
                                              puts "**************Busqueda De la linea_color #{linea_color}**************************"


                                                        if @bus_linea_color== nil
                                                          puts "**************La linea_color es nula**************************"
                                                          linea_colorNueva = LineaDeColor.new(nombre: linea_color)
                                                          if linea_colorNueva.save
                                                              puts "**************La linea_color a sido Creada**************************"
                                                              @linea_color_id=linea_colorNueva.id
                                                          end
                                                        else
                                                          puts "**************La linea_color Existe**************************"
                                                            @linea_color_id=@bus_linea_color.id
                                                        end
                                        else
                                                puts "**************La El campo Pieza esta vacio**************************"
                                                busqueda="Por Definir"
                                                @bus_linea_color= LineaDeColor.find_by(nombre: busqueda)
                                                puts "**************Busqueda De la linea_color nulas**************************"

                                                          busqueda="Por Definir"
                                                          if @bus_linea_color== nil
                                                              linea_colorNueva = LineaDeColor.new(nombre: busqueda)
                                                              if linea_colorNueva.save
                                                                  puts "**************La linea_color a sido Creada y se Por Definir**************************"
                                                                  @linea_color_id=linea_colorNueva.id
                                                              end
                                                          else
                                                              @linea_color_id=@bus_linea_color.id
                                                          end
                                        end





                                        linea_producto =  spreadsheet.row(i)[3].to_s.upcase
                                        if linea_producto.length != 0
                                              @bus_linea_producto= LineaProducto.find_by(nombre: linea_producto)
                                              puts "**************Busqueda De la linea_producto**************************"


                                                        if @bus_linea_producto== nil
                                                          puts "**************La linea_producto es nula**************************"
                                                          linea_productoNueva = LineaProducto.new(nombre: linea_producto)
                                                          if linea_productoNueva.save
                                                              puts "**************La linea_producto a sido Creada**************************"
                                                              @linea_producto_id=linea_productoNueva.id
                                                          end
                                                        else
                                                          puts "**************La linea_producto Existe**************************"
                                                            @linea_producto_id=@bus_linea_producto.id
                                                        end
                                        else
                                                puts "**************La El campo linea de producto esta vacio**************************"
                                                busqueda="Por Definir"
                                                @bus_linea_producto= LineaProducto.find_by(nombre: busqueda)
                                                puts "**************Busqueda De la linea_producto nulas**************************"

                                                          busqueda="Por Definir"
                                                          if @bus_linea_producto== nil
                                                              linea_productoNueva = LineaProducto.new(nombre: busqueda)
                                                              if linea_productoNueva.save
                                                                  puts "**************La linea_producto a sido Creada y es Por Definir**************************"
                                                                  @linea_producto_id=linea_productoNueva.id
                                                              end
                                                          else
                                                              @linea_producto_id=@bus_linea_producto.id
                                                          end
                                        end
                                        nombre_montaje = spreadsheet.row(i)[8].to_s.upcase


                                        nombre_de_material = spreadsheet.row(i)[16].to_s.upcase
                                        if nombre_de_material.length != 0
                                              @bus_material= Material.find_by(descripcion: nombre_de_material)
                                              puts "**************Busqueda Del Material**************************"


                                                        if @bus_material== nil
                                                          puts "**************El material es nulo**************************"
                                                          materialNuevo = Material.new(descripcion: nombre_de_material, codigo: "")
                                                          if materialNuevo.save
                                                              puts "**************El material a sido Creada**************************"
                                                              @material_id=materialNuevo.id
                                                          end
                                                        else
                                                          puts "**************La linea_producto Existe**************************"
                                                            @material_id=@bus_material.id
                                                        end
                                        else
                                                puts "**************La El campo material esta vacio**************************"
                                                busqueda="Por Definir".to_s.upcase
                                                @bus_material= Material.find_by(descripcion: busqueda)
                                                puts "**************Busqueda Del material es nulo**************************"

                                                          busqueda="Por Definir".upcase
                                                          if @bus_material== nil
                                                              materialNuevo = Material.new(descripcion: busqueda, codigo: "")
                                                              if materialNuevo.save
                                                                  puts "**************La linea_producto a sido Creada y es Por Definir**************************"
                                                                  @material_id= materialNuevo.id
                                                              end
                                                          else
                                                              @material_id=@bus_material.id
                                                          end
                                        end

                                        puts "******************INICIO DE INSERCION **********************".red
                                        puts "******************LINEA COLOR: #{@linea_color_id}**********************".blue
                                        puts "******************LINEA PRODUCTO: #{@linea_producto_id}**********************".blue
                                        puts "******************CLIENTE: #{@cliente_id}**********************".blue
                                        puts "******************MATERIAL: #{@material_id}**********************".blue

                                        montajeNuevo = Montaje.new(cliente_id: @cliente_id, codigo: "", nombre: nombre_montaje, linea_de_color_id: @linea_color_id, linea_producto_id: @linea_producto_id, material_id: @material_id)

                                        if montajeNuevo.save
                                                puts "***********El Montaje a sido almacenado*****************************"
                                                @montaje_id = montajeNuevo.id

                                                contacto_nombre = spreadsheet.row(i)[52].to_s.upcase
                                                puts "***************Crear contacto - <(*) #{contacto_nombre} (*)> - para orden************************".green

                                                if contacto_nombre.length != 0
                                                      @bus_contacto= Contacto.find_by(nombre_contacto: contacto_nombre)
                                                      puts "**************Busqueda Del contacto**************************"


                                                                if @bus_contacto == nil
                                                                  puts "**************El contacto es nulo**************************"
                                                                  contactoNuevo = Contacto.new(nombre_contacto: contacto_nombre)
                                                                  if contactoNuevo.save
                                                                      puts "**************La linea_producto a sido Creada**************************"
                                                                      @contacto_id=contactoNuevo.id
                                                                  end
                                                                else
                                                                  puts "**************el contacto Existe**************************"
                                                                    @contacto_id=@bus_contacto.id
                                                                end
                                                else
                                                        puts "**************La El campo contacto esta vacio**************************"
                                                        busqueda = "SIN DEFINIR"
                                                        @bus_contacto = Contacto.find_by(nombre_contacto: busqueda)
                                                        puts "**************Busqueda De la linea_producto nulas**************************"


                                                                  if @bus_contacto== nil

                                                                  else
                                                                      @contacto_id=@bus_contacto.id
                                                                  end
                                                end

                                                puts "***************Crear Facturar a para orden*************************".green
                                                if facturar_a_nombre != 0
                                                      @bus_facturar_a= FacturarA.find_by(nombre: contacto_nombre)
                                                      puts "**************Busqueda Del Fac**************************".yellow


                                                                if @bus_facturar_a == nil

                                                                else
                                                                  puts "**************La fac Existe**************************".yellow
                                                                    @facturar_a_id=@bus_facturar_a.id
                                                                end
                                                else
                                                        puts "**************La El campo fac esta vacio**************************".yellow
                                                        busqueda = "SIN DEFINIR"
                                                        @bus_facturar_a = FacturarA.find_by(nombre: busqueda)
                                                        puts "**************Busqueda De la linea_producto nulas**************************".yellow


                                                                  if @bus_facturar_a== nil

                                                                  else
                                                                    puts "****************id del contacto es: #{@bus_facturar_a.id}************************".red
                                                                      @facturar_a_id=@bus_facturar_a.id
                                                                  end
                                                end

                                                fecha_de_orden = spreadsheet.row(i)[4]
                                                puts "***************fecha a parsear #{fecha_de_orden}*************************"
                                                fecha=fecha_de_orden.to_date
                                                puts "****************Fecha Parseada #{fecha}************************"

                                                ordenNueva=OrdenProduccion.new(montaje_id:@montaje_id, numero_de_orden:numero_orden, fecha:fecha)
                                                if ordenNueva.save
                                                  puts "*******************Orden Almacenada*********************"
                                                  fecha_de_compromiso = spreadsheet.row(i)[4]
                                                  fecha_compromiso=fecha_de_compromiso.strftime("%Y/%m/%d").to_date
                                                  puts "*******************Orden Almacenada*********************"
                                                  compromiso= CompromisoDeEntrega.new(orden_produccion_id:ordenNueva.id, fecha_de_compromiso: fecha_compromiso)

                                                  if compromiso.save

                                                    puts "*******************Fecha de compromiso Almacenada*********************"

                                                  end
                                                  else
                                                    puts "*******************Orden Fallida*********************"
                                                end
                                        else
                                                puts "******************EL MONTAJE NO EXISTE**********************".green
                                        end






                          else
                                        puts "***********el montaje si existe y el id: #{@bus_montaje}*****************************"
                                        contacto_nombre = spreadsheet.row(i)[52]


                                        puts "***************Crear contacto - <(*) #{contacto_nombre} (*)> - para orden************************".green

                                        if contacto_nombre.length != 0
                                              @bus_contacto= Contacto.find_by(nombre_contacto: contacto_nombre)
                                              puts "**************Busqueda Del contacto**************************"


                                                        if @bus_contacto == nil
                                                          puts "**************El contacto es nulo**************************"
                                                          contactoNuevo = Contacto.new(nombre_contacto: contacto_nombre)
                                                          if contactoNuevo.save
                                                              puts "**************La linea_producto a sido Creada**************************"
                                                              @contacto_id=contactoNuevo.id
                                                          end
                                                        else
                                                          puts "**************el contacto Existe**************************"
                                                            @contacto_id=@bus_contacto.id
                                                        end
                                        else
                                                puts "**************La El campo contacto esta vacio**************************"
                                                busqueda = "SIN DEFINIR"
                                                @bus_contacto = Contacto.find_by(nombre_contacto: busqueda)
                                                puts "**************Busqueda De la linea_producto nulas**************************"


                                                          if @bus_contacto== nil

                                                          else
                                                              @contacto_id=@bus_contacto.id
                                                          end
                                        end

                                        puts "***************Crear Facturar a para orden*************************".green
                                        if facturar_a_nombre != 0
                                              @bus_facturar_a= FacturarA.find_by(nombre: contacto_nombre)
                                              puts "**************Busqueda Del Fac**************************".yellow


                                                        if @bus_facturar_a == nil

                                                        else
                                                          puts "**************La fac Existe**************************".yellow
                                                            @facturar_a_id=@bus_facturar_a.id
                                                        end
                                        else
                                                puts "**************La El campo fac esta vacio**************************".yellow
                                                busqueda = "SIN DEFINIR"
                                                @bus_facturar_a = FacturarA.find_by(nombre: busqueda)
                                                puts "**************Busqueda De la linea_producto nulas**************************".yellow


                                                          if @bus_facturar_a== nil

                                                          else
                                                            puts "****************id del contacto es: #{@bus_facturar_a.id}************************".red
                                                              @facturar_a_id=@bus_facturar_a.id
                                                          end
                                        end

                                        fecha_de_compromiso = spreadsheet.row(i)[4]
                                        fecha_compromiso=fecha_de_compromiso.strftime("%Y/%m/%d").to_date
                                        puts "*******************Orden Almacenada*********************"

                                        cantidad_programada = spreadsheet.row(i)[9]
                                        precio_unitario = spreadsheet.row(i)[10]
                                        tipo_trabajo = spreadsheet.row(i)[12]
                                        cavidad = spreadsheet.row(i)[14]
                                        tamanos_totales = spreadsheet.row(i)[13]
                                        tamano_1 = spreadsheet.row(i)[46]
                                        tamano_2 = spreadsheet.row(i)[47]
                                        cantidad_hojas = spreadsheet.row(i)[48]
                                        observacion = spreadsheet.row(i)[51]

                                        @montaje_op_id = @bus_montaje.id
                                        fecha_de_orden = spreadsheet.row(i)[4]
                                        puts "***************fecha a parsear #{fecha_de_orden}*************************"
                                        fecha=fecha_de_orden.to_date
                                        puts "****************Fecha Parseada #{fecha}************************"

                                        ordenNueva=OrdenProduccion.new(montaje_id:@bus_montaje.id, numero_de_orden:numero_orden , fecha:fecha)
                                        if ordenNueva.save
                                          puts "*******************Orden Almacenada*********************"






                                          compromiso= CompromisoDeEntrega.new(orden_produccion_id:ordenNueva.id, fecha_de_compromiso: fecha_compromiso)

                                          if compromiso.save

                                            puts "*******************Fecha de compromiso Almacenada*********************"

                                          end
                                          else
                                            puts "*******************Orden Fallida*********************"
                                        end
                          end




                          end


            end




      end




    end

    if @errores != []
      return @errores
    else
      return true
    end
  end


def self.importar_excel_individual(file,montaje_seleccionado,
  linea_de_producto_seleccionada,linea_de_color_seleccionada,maquinas_seleccionadas,
  comercial_id,inventario,fecha_de_orden,agregar_acabados, seleccion_acabados, cliente_id,fecha_compromiso)
  #code
  puts "********************START********************".red
  puts "********************COMERCIAL ID: #{comercial_id}********************"
  @errores = []

  file_ext = File.extname(file.original_filename)
  raise "Unknown file type: #{file.original_filename}" unless [".xls", ".xlsx", ".csv"].include?(file_ext)

  if file_ext == ".xlsx"
    spreadsheet = Roo::Excelx.new(file.path)
  elsif file_ext == ".xls"
    spreadsheet = Roo::Excel.new(file.path)
  elsif file_ext == ".csv"
    spreadsheet = Roo::CSV.new(file.path)
  end

  header = spreadsheet.row(1)


      puts "****************ITERACION************************".yellow
      numero_orden = spreadsheet.cell(4,'B')
      puts "******************* NUMERO DE ORDEN : <(*) - #{numero_orden} - (*)>*********************".green

      if numero_orden.length > 0
        puts "******************STRING LLLENO**********************".blue
        puts "*******************<(*) - #{numero_orden} - (*)>*********************".green
        numero_op = numero_orden.to_s.upcase
        op = OrdenProduccion.find_by(numero_de_orden: numero_op)

        #consulta de orden_nueva
        if op == nil
          puts "***************** ORDEN NO EXISTE***********************".red

          if montaje_seleccionado.present?
            puts "====================EL MONTAJE FUE SELECCIONADO=====================".green
            buscar_cliente = Montaje.find_by(id: montaje_seleccionado)
            cliente_id = buscar_cliente.cliente.id
            #busqueda de ORDENES
            puts "*******************SESION DE ORDENES*********************"

            #busquea de contactos
            contacto_nombre = spreadsheet.cell(10,'B').to_s.upcase
            puts "***************Crear contacto - <(*) #{contacto_nombre} (*)> - para orden************************".green

                        if contacto_nombre.length != 0
                              @bus_contacto= Contacto.find_by(nombre_contacto: contacto_nombre)
                              puts "**************Busqueda Del contacto**************************".red


                                        if @bus_contacto == nil
                                        puts "******************EL CONTACTO NO EXISTE**********************".red





                                          #Busqueda de vendedor
                                          if comercial_id.present?

                                            puts "*******************EL COMERCIAL HA SIDO SELECCIONADO*********************".green

                                            contactoNuevo = Contacto.new(nombre_contacto: contacto_nombre,cliente_id:cliente_id, user_id: comercial_id)
                                            if contactoNuevo.save
                                                puts "************** El contacto ha sido creado **************************".green
                                                @contacto_id=contactoNuevo.id
                                            end

                                          else
                                            puts "*******************EL COMERCIAL NO HA SIDO SELECCIONADO*********************".red


                                                            vendedor_nombre = spreadsheet.cell(14,'C').to_s.upcase
                                                            puts "******************nombre vendedor: #{vendedor_nombre}**********************".green
                                                                      if vendedor_nombre.length > 0
                                                                        puts "*****************vendedor existe***********************".green
                                                                        vendedor = User.find_by(nombre: vendedor_nombre)
                                                                                  if vendedor == nil
                                                                                    puts "******************VENDEDOR NO EXISTE**********************".red

                                                                                  else

                                                                                              puts "******************VENDEDOR EXISTE**********************".yellow
                                                                                              puts "**************CREACION DEL CONTACTO**************************".yellow
                                                                                              puts "**************CLIENTE ID: #{cliente_id}**************************".blue

                                                                                              puts "**************NOMBRE CONTACTO: #{contacto_nombre}**************************".blue
                                                                                              contactoNuevo = Contacto.new(nombre_contacto: contacto_nombre,cliente_id:cliente_id, user_id: vendedor.id)
                                                                                              if contactoNuevo.save
                                                                                                  puts "************** El contacto ha sido creado **************************".green
                                                                                                  @contacto_id=contactoNuevo.id
                                                                                              end

                                                                                  end
                                                                      else
                                                                        puts "****************STRING VENDEDOR VACIO************************".red
                                                                      end


                                                 end








                                        else
                                          puts "**************EL CONTACTO  EXISTE**************************".green
                                            @contacto_id=@bus_contacto.id
                                        end
                        else
                                puts "**************La El campo contacto esta vacio**************************"
                                busqueda = "SIN DEFINIR"
                                @bus_contacto = Contacto.find_by(nombre_contacto: busqueda)
                                puts "**************Busqueda De la linea_producto nulas**************************"


                                          if @bus_contacto== nil

                                          else
                                              @contacto_id=@bus_contacto.id
                                          end
                        end


                               #busqueda nombre facturacion
                               facturar_a_nombre= spreadsheet.cell(8,'H').to_s.upcase
                               puts "*************** Facturar a - <(*) #{facturar_a_nombre} (*)> - para orden************************".green

                               if facturar_a_nombre.length != 0

                                     puts "**************Busqueda Del Facturado**************************".red
                                     @bus_facturar_a = NombreFacturacion.find_by(nombre: facturar_a_nombre)



                                               if @bus_facturar_a == nil
                                                 puts "***********EL NOMBRE DE FACTURACION NO EXISTE*****************************".yellow





                                                 #CREAR FACTURAR A:

                                                 puts "******************nombre vendedor: #{vendedor_nombre}**********************".green

                                                             puts "*****************vendedor existe***********************".green



                                                                         puts "******************VENDEDOR EXISTE**********************".yellow
                                                                         puts "**************CREACION DEL CONTACTO**************************".yellow
                                                                         puts "**************CLIENTE ID: #{cliente_id}**************************".blue

                                                                         puts "**************facturar_a: #{facturar_a_nombre}**************************".blue
                                                                         facturar_aNuevo = NombreFacturacion.new(nombre: facturar_a_nombre,cliente_id:cliente_id)
                                                                         if facturar_aNuevo.save
                                                                             puts "************** El contacto ha sido creado **************************".green
                                                                             @facturar_a_id=facturar_aNuevo.id
                                                                         end

                                               else
                                                 puts "*************la factura existe Existe**************************".green
                                                   @facturar_a_id=@bus_facturar_a.id
                                               end


                               else
                                       puts "**************La El campo contacto esta vacio**************************"
                                       busqueda = "SIN DEFINIR"
                                       @bus_facturar_a = NombreFacturacion.find_by(nombre: busqueda)
                                       puts "**************Busqueda De la facturacion nulas**************************"


                                                 if @bus_facturar_a== nil

                                                 else
                                                     @facturar_a_id = @bus_facturar_a.id
                                                 end
                               end









                               #lugar a despachar
                               lugar_despacho_nombre= spreadsheet.cell(9,'B').to_s.upcase
                               puts "*************** Facturar a - <(*) #{lugar_despacho_nombre} (*)> - para orden************************".green

                               if lugar_despacho_nombre.length != 0

                                     puts "**************Busqueda Del lUGAR DESPACHO**************************".red
                                     @bus_lugar_despacho = LugarDespacho.find_by(direccion: lugar_despacho_nombre)



                                               if @bus_lugar_despacho == nil
                                                 puts "***********EL NOMBRE DE DESPACHO NO EXISTE*****************************".yellow





                                                 #crear lugar deapachos



                                                                         puts "******************VENDEDOR EXISTE**********************".yellow
                                                                         puts "**************CREACION DEL LUGAR DEL DESPACHO**************************".yellow
                                                                         puts "**************CLIENTE ID: #{cliente_id}**************************".blue

                                                                         puts "**************facturar_a: #{lugar_despacho_nombre}**************************".blue
                                                                         lugar_despachoNuevo = LugarDespacho.new(direccion: lugar_despacho_nombre,cliente_id:cliente_id)
                                                                         if lugar_despachoNuevo.save
                                                                             puts "************** El lugar despacho ha sido creado **************************".green
                                                                             @lugar_despacho_id=lugar_despachoNuevo.id
                                                                         end



                                               else
                                                 puts "**************el lugar despacho Existe**************************".green
                                                   @lugar_despacho_id=@bus_lugar_despacho.id
                                               end
                               else
                                       puts "**************La El campo lugar despachos esta vacio**************************"
                                       busqueda = "SIN DEFINIR"
                                       @bus_lugar_despacho = LugarDespacho.find_by(direccion: busqueda)
                                       puts "**************Busqueda De la linea_producto nulas**************************"


                                                 if @bus_lugar_despacho == nil

                                                 else
                                                     @lugar_despacho_id = @bus_lugar_despacho.id
                                                 end
                               end




                               if @contacto_id.present? && @facturar_a_id.present? && @lugar_despacho_id.present?
                                 puts "****************LOS DATOS NECESARIOS EXISTEN************************".blue
                                 puts "****************CONTACTO: #{@contacto_id}************************".green
                                 puts "****************FACTURAR A: #{@facturar_a_id}************************".green
                                 puts "****************LUGAR DESPACHO ID: #{@lugar_despacho_id}************************".green

                                 orden_de_compra = spreadsheet.cell(10,'L').to_s.upcase
                                 cantidad_solicitada = spreadsheet.cell(11,'L')
                                 cantidad_hoja = spreadsheet.cell(21,'B')
                                 tamanos_totales_op = spreadsheet.cell(22,'K')
                                 obs= spreadsheet.cell(63,'C')
                                 obs2 = spreadsheet.cell(64,'A')
                                 obs3 = spreadsheet.cell(65,'A')
                                 obs4 = spreadsheet.cell(66,'A')
                                 observacion = obs.to_s + "\n" + obs2.to_s + "\n" + obs3.to_s + "\n" + obs4

                                 puts "================VALOR 1========================".yellow
                                 puts "******************#{tamanos_totales_op}**********************".blue
                                 puts "========================================".yellow
                                 cavidad = spreadsheet.cell(21,'G')
                                 cantidad_programada = tamanos_totales_op.to_f * cavidad.to_f

                                 puts "=================VALOR 2=======================".yellow
                                 puts "******************#{tamanos_totales_op}**********************".blue
                                 puts "========================================".yellow
                                 fecha = fecha_de_orden
                                 sacar_de_inventario = inventario
                                 habilitar_impresion = true
                                 if inventario == true
                                   habilitar_impresion =false
                                 end
                                 precio_unitario = spreadsheet.cell(13,'D')
                                 ordenCreada = OrdenProduccion.new(numero_de_orden:numero_op,precio_unitario:precio_unitario,habilitar_impresion:habilitar_impresion,sacar_de_inventario:sacar_de_inventario,fecha:fecha,observacion:observacion,cantidad_programada:cantidad_programada,cavidad:cavidad,tamanos_total:tamanos_totales_op,cantidad_hoja:cantidad_hoja,cantidad_solicitada:cantidad_solicitada,orden_de_compra:orden_de_compra,montaje_id: montaje_seleccionado, contacto_id: @contacto_id, nombre_facturacion_id:@facturar_a_id, lugar_despacho_id:@lugar_despacho_id)
                                 if ordenCreada.save
                                   puts "*****************ORDEN DE PRODUCCION***********************".green
                                   if fecha_compromiso.present?
                                     puts "******************LA FECHA DE COMPROISO EXITES Y ES #{fecha_compromiso}**********************".yellow
                                     compromisos_de_entrega = CompromisoDeEntrega.new(orden_produccion_id:ordenCreada.id,fecha_de_compromiso:fecha_compromiso, cantidad:cantidad_solicitada)
                                     if compromisos_de_entrega.save
                                       puts "*******************COMPROMISO DE ENTREGA CREADO*********************".green
                                     end
                                   end
                                 end
                               else
                               end
          else





          descripcion_montaje = spreadsheet.cell(11,'E').to_s.upcase
          puts "******************MONTAJE #{descripcion_montaje}**********************".blue

                #consulta de montaje
                if descripcion_montaje.length > 0
                            puts "*****************STRING LLENO***********************".green
                            montaje = Montaje.find_by(nombre: descripcion_montaje)
                            if montaje == nil
                                    puts "**************MONTAJE NO EXISTE**************************".red

                                    cliente_nombre = spreadsheet.cell(8,'B').to_s.upcase
                                    puts "****************NOMBRE DEL CLIENTE: #{cliente_nombre}************************"
                                    if cliente_nombre.length > 0

                                        puts "******************El CLIENTE STRING LLENO #{cliente_nombre}**********************".green
                                        puts "******************BUSCAR CLIENTE**********************".blue
                                        cliente = Cliente.find_by(nombre: cliente_nombre)
                                        if cliente == nil
                                          puts "*****************EL CLIENTE NO EXISTE***********************".yellow

                                          #Busqueda de vendedor
                                          vendedor_nombre = spreadsheet.cell(14,'C').to_s.upcase
                                          puts "******************nombre vendedor: #{vendedor_nombre}**********************".green
                                                    if vendedor_nombre.length > 0
                                                      puts "*****************vendedor existe***********************".green
                                                      vendedor = User.find_by(nombre: vendedor_nombre)
                                                                if vendedor == nil
                                                                  puts "******************VENDEDOR NO EXISTE**********************".red

                                                                else
                                                                  puts "******************VENDEDOR EXISTE**********************".yellow
                                                                  clienteNuevo = Cliente.new(nombre:cliente_nombre, user_id: vendedor.id)
                                                                  if clienteNuevo.save
                                                                    puts "***********El Cliente a sido Almacenado*****************************".green
                                                                    cliente_id = clienteNuevo.id
                                                                    puts "**************CLIENTE NUEVO: #{cliente_id}**************************"
                                                                  end
                                                                end
                                                    else
                                                      puts "****************STRING VENDEDOR VACIO************************".red
                                                    end


                                        else
                                          puts "*****************EL CLIENTE EXISTE #{cliente.nombre}***********************".green
                                          cliente_id =cliente.id
                                        end

                                    else
                                      puts "*****************CLIENTE ES UN STRING VACIO***********************".red
                                    end



                                    puts "*******************<(*)salimos de la creacion del cliente (*)>*********************".yellow
                                    #Consular linea de color
                                    linea_color =  spreadsheet.cell(6,'G').to_s.upcase
                                    if linea_de_color_seleccionada.present?
                                      puts "*******************LA LINEA DE COLOR FUE SELECCIONADA*********************".green
                                      @linea_color_id = linea_de_color_seleccionada
                                    else



                                            if linea_color.length != 0
                                                  @bus_linea_color= LineaDeColor.find_by(nombre: linea_color)
                                                  puts "**************Busqueda De la linea_color #{linea_color}**************************"


                                                            if @bus_linea_color== nil
                                                              puts "**************La linea_color es nula**************************"
                                                              linea_colorNueva = LineaDeColor.new(nombre: linea_color)
                                                              if linea_colorNueva.save
                                                                  puts "**************La linea_color a sido Creada**************************"
                                                                  @linea_color_id=linea_colorNueva.id
                                                              end
                                                            else
                                                              puts "**************La linea_color Existe**************************"
                                                                @linea_color_id=@bus_linea_color.id
                                                            end
                                            else
                                                    puts "**************La El campo Pieza esta vacio**************************"
                                                    busqueda="Por Definir"
                                                    @bus_linea_color= LineaDeColor.find_by(nombre: busqueda)
                                                    puts "**************Busqueda De la linea_color nulas**************************"

                                                              busqueda="Por Definir"
                                                              if @bus_linea_color== nil
                                                                  linea_colorNueva = LineaDeColor.new(nombre: busqueda)
                                                                  if linea_colorNueva.save
                                                                      puts "**************La linea_color a sido Creada y se Por Definir**************************"
                                                                      @linea_color_id=linea_colorNueva.id
                                                                  end
                                                              else
                                                                  @linea_color_id=@bus_linea_color.id
                                                              end
                                            end
                                    end


                                    #Consultar Material
                                    nombre_de_material = spreadsheet.cell(20,'D').to_s.upcase
                                    if nombre_de_material.length != 0
                                          @bus_material= Material.find_by(descripcion: nombre_de_material)
                                          puts "**************Busqueda Del Material**************************"


                                                    if @bus_material== nil
                                                      puts "**************El material es nulo**************************"
                                                      materialNuevo = Material.new(descripcion: nombre_de_material, codigo: "")
                                                      if materialNuevo.save
                                                          puts "**************El material a sido Creada**************************"
                                                          @material_id=materialNuevo.id
                                                      end
                                                    else
                                                      puts "**************La linea_producto Existe**************************"
                                                        @material_id=@bus_material.id
                                                    end
                                    else
                                            puts "**************La El campo material esta vacio**************************"
                                            busqueda="Por Definir".to_s.upcase
                                            @bus_material= Material.find_by(descripcion: busqueda)
                                            puts "**************Busqueda Del material es nulo**************************"

                                                      busqueda="Por Definir".upcase
                                                      if @bus_material== nil
                                                          materialNuevo = Material.new(descripcion: busqueda, codigo: "")
                                                          if materialNuevo.save
                                                              puts "**************La linea_producto a sido Creada y es Por Definir**************************"
                                                              @material_id= materialNuevo.id
                                                          end
                                                      else
                                                          @material_id=@bus_material.id
                                                      end
                                    end

                                    #Consultar linea de producto
                                    linea_producto =  spreadsheet.cell(6,'C').to_s.upcase
                                    if linea_de_producto_seleccionada.present?
                                      puts "******************LA LINEA DE PRODUCTO FUE SELECCIONADA**********************".green
                                      @linea_producto_id= linea_de_producto_seleccionada
                                    else
                                            if linea_producto.length != 0


                                                  @bus_linea_producto= LineaProducto.find_by(nombre: linea_producto)
                                                  puts "**************Busqueda De la linea_producto**************************"


                                                            if @bus_linea_producto== nil
                                                              puts "**************La linea_producto es nula**************************"
                                                              linea_productoNueva = LineaProducto.new(nombre: linea_producto)
                                                              if linea_productoNueva.save
                                                                  puts "**************La linea_producto a sido Creada**************************"
                                                                  @linea_producto_id=linea_productoNueva.id
                                                              end
                                                            else
                                                              puts "**************La linea_producto Existe**************************"
                                                                @linea_producto_id=@bus_linea_producto.id
                                                            end
                                            else
                                                    puts "**************La El campo linea de producto esta vacio**************************"
                                                    busqueda="Por Definir"
                                                    @bus_linea_producto= LineaProducto.find_by(nombre: busqueda)
                                                    puts "**************Busqueda De la linea_producto nulas**************************"

                                                              busqueda="Por Definir"
                                                              if @bus_linea_producto== nil
                                                                  linea_productoNueva = LineaProducto.new(nombre: busqueda)
                                                                  if linea_productoNueva.save
                                                                      puts "**************La linea_producto a sido Creada y es Por Definir**************************"
                                                                      @linea_producto_id=linea_productoNueva.id
                                                                  end
                                                              else
                                                                  @linea_producto_id=@bus_linea_producto.id
                                                              end
                                            end
                                      end
                                    #Insercion
                                    puts "******************INICIO DE INSERCION **********************".red
                                    puts "******************LINEA COLOR: #{@linea_color_id}**********************".blue
                                    puts "******************LINEA PRODUCTO: #{@linea_producto_id}**********************".blue
                                    puts "******************CLIENTE: #{@cliente_id}**********************".blue
                                    puts "******************MATERIAL: #{@material_id}**********************".blue
                                    nombre_montaje = spreadsheet.cell(11,'E').to_s.upcase
                                    dimension = spreadsheet.cell(12,'D').to_s.upcase
                                    dimension = dimension.split(" CM")

                                    tamano_dimension = ""
                                    dimension.each do |dim|
                                      tamano_dimension = dim
                                      puts "*************************************************************************".blue
                                      puts "*******************el tamano es: #{tamano_dimension}*********************".yellow
                                      puts "*************************************************************************".blue
                                    end

                                    tamano_1 = spreadsheet.cell(20,'K')
                                    tamano_2 = spreadsheet.cell(20,'M')

                                    tamano_hoja= tamano_1.to_s + "X"+tamano_2.to_s

                                    tamano_por_hojas = spreadsheet.cell(22,'G')


                                    tamano_corte_1 = spreadsheet.cell(21,'K')
                                    tamano_corte_2 = spreadsheet.cell(21,'M')

                                    tamano_de_corte = tamano_corte_1.to_s + "X" + tamano_corte_2.to_s
                                    modo_de_empaque = spreadsheet.cell(60,'D')

                                    montajeNuevo = Montaje.new(cliente_id: cliente_id, modo_de_empaque:modo_de_empaque,agregar_acabado:agregar_acabados,acabado_ids:seleccion_acabados,codigo: "", nombre: nombre_montaje, dimension:tamano_dimension,tamano_hoja:tamano_hoja,tamano_por_hojas:tamano_por_hojas,tamano_de_corte:tamano_de_corte,linea_de_color_id: @linea_color_id, linea_producto_id: @linea_producto_id, material_id: @material_id)

                                    if montajeNuevo.save
                                         puts "*******************REGISTRO DE MONTAJE GUARDADO*********************".green

                                         #busqueda de ORDENES
                                         puts "*******************SESION DE ORDENES*********************"

                                         #busquea de contactos CR
                                         contacto_nombre = spreadsheet.cell(10,'B').to_s.upcase
                                         puts "***************Crear contacto - <(*) #{contacto_nombre} (*)> - para orden************************".green

                                                     if contacto_nombre.length != 0
                                                           @bus_contacto= Contacto.find_by(nombre_contacto: contacto_nombre)
                                                           puts "**************Busqueda Del contacto**************************".red


                                                                     if @bus_contacto == nil
                                                                     puts "******************EL CONTACTO NO EXISTE**********************".red





                                                                       #Busqueda de vendedor
                                                                       if comercial_id.present?
                                                                         puts "*******************EL COMERCIAL HA SIDO SELECCIONADO*********************".green
                                                                         contactoNuevo = Contacto.new(nombre_contacto: contacto_nombre,cliente_id:cliente_id, user_id: comercial_id)
                                                                         if contactoNuevo.save
                                                                             puts "************** El contacto ha sido creado **************************".green
                                                                             @contacto_id=contactoNuevo.id
                                                                         end

                                                                       else
                                                                         puts "*******************EL COMERCIAL NO HA SIDO SELECCIONADO*********************".red


                                                                                         vendedor_nombre = spreadsheet.cell(14,'C').to_s.upcase
                                                                                         puts "******************nombre vendedor: #{vendedor_nombre}**********************".green
                                                                                                   if vendedor_nombre.length > 0
                                                                                                     puts "*****************vendedor existe***********************".green
                                                                                                     vendedor = User.find_by(nombre: vendedor_nombre)
                                                                                                               if vendedor == nil
                                                                                                                 puts "******************VENDEDOR NO EXISTE**********************".red

                                                                                                               else

                                                                                                                           puts "******************VENDEDOR EXISTE**********************".yellow
                                                                                                                           puts "**************CREACION DEL CONTACTO**************************".yellow
                                                                                                                           puts "**************CLIENTE ID: #{cliente_id}**************************".blue
                                                                                                                           puts "**************VENDEDOR ID: #{vendedor.id}**************************".blue
                                                                                                                           puts "**************NOMBRE CONTACTO: #{contacto_nombre}**************************".blue
                                                                                                                           contactoNuevo = Contacto.new(nombre_contacto: contacto_nombre,cliente_id:cliente_id, user_id: vendedor.id)
                                                                                                                           if contactoNuevo.save
                                                                                                                               puts "************** El contacto ha sido creado **************************".green
                                                                                                                               @contacto_id=contactoNuevo.id
                                                                                                                           end

                                                                                                               end
                                                                                                   else
                                                                                                     puts "****************STRING VENDEDOR VACIO************************".red
                                                                                                   end


                                                                              end








                                                                     else
                                                                       puts "**************EL CONTACTO  EXISTE**************************".green
                                                                         @contacto_id=@bus_contacto.id
                                                                     end
                                                     else
                                                             puts "**************La El campo contacto esta vacio**************************"
                                                             busqueda = "SIN DEFINIR"
                                                             @bus_contacto = Contacto.find_by(nombre_contacto: busqueda)
                                                             puts "**************Busqueda De la linea_producto nulas**************************"


                                                                       if @bus_contacto== nil

                                                                       else
                                                                           @contacto_id=@bus_contacto.id
                                                                       end
                                                     end


                                                            #busqueda nombre facturacion
                                                            facturar_a_nombre= spreadsheet.cell(8,'H').to_s.upcase
                                                            puts "*************** Facturar a - <(*) #{facturar_a_nombre} (*)> - para orden************************".green

                                                            if facturar_a_nombre.length != 0

                                                                  puts "**************Busqueda Del Facturado**************************".red
                                                                  @bus_facturar_a = NombreFacturacion.find_by(nombre: facturar_a_nombre)



                                                                            if @bus_facturar_a == nil
                                                                              puts "***********EL NOMBRE DE FACTURACION NO EXISTE*****************************".yellow





                                                                              #Busqueda de vendedor
                                                                              vendedor_nombre = spreadsheet.cell(14,'C').to_s.upcase
                                                                              puts "******************nombre vendedor: #{vendedor_nombre}**********************".green
                                                                                        if vendedor_nombre.length > 0
                                                                                          puts "*****************vendedor existe***********************".green
                                                                                          vendedor = User.find_by(nombre: vendedor_nombre)
                                                                                                    if vendedor == nil
                                                                                                      puts "******************VENDEDOR NO EXISTE**********************".red

                                                                                                    else

                                                                                                      puts "******************VENDEDOR EXISTE**********************".yellow
                                                                                                      puts "**************CREACION DEL CONTACTO**************************".yellow
                                                                                                      puts "**************CLIENTE ID: #{cliente_id}**************************".blue
                                                                                                      puts "**************VENDEDOR ID: #{vendedor.id}**************************".blue
                                                                                                      puts "**************facturar_a: #{facturar_a_nombre}**************************".blue
                                                                                                      facturar_aNuevo = NombreFacturacion.new(nombre: facturar_a_nombre,cliente_id:cliente_id)
                                                                                                      if facturar_aNuevo.save
                                                                                                          puts "************** El contacto ha sido creado **************************".green
                                                                                                          @facturar_a_id=facturar_aNuevo.id
                                                                                                      end

                                                                                                    end
                                                                                        else
                                                                                          puts "****************STRING VENDEDOR VACIO************************".red
                                                                                        end











                                                                            else
                                                                              puts "*************la factura existe Existe**************************".green
                                                                                @facturar_a_id=@bus_facturar_a.id
                                                                            end


                                                            else
                                                                    puts "**************La El campo contacto esta vacio**************************"
                                                                    busqueda = "SIN DEFINIR"
                                                                    @bus_facturar_a = NombreFacturacion.find_by(nombre: busqueda)
                                                                    puts "**************Busqueda De la facturacion nulas**************************"


                                                                              if @bus_facturar_a== nil

                                                                              else
                                                                                  @facturar_a_id = @bus_facturar_a.id
                                                                              end
                                                            end









                                                            #lugar a despachar
                                                            lugar_despacho_nombre= spreadsheet.cell(9,'B').to_s.upcase
                                                            puts "*************** Facturar a - <(*) #{lugar_despacho_nombre} (*)> - para orden************************".green

                                                            if lugar_despacho_nombre.length != 0

                                                                  puts "**************Busqueda Del lUGAR DESPACHO**************************".red
                                                                  @bus_lugar_despacho = LugarDespacho.find_by(direccion: lugar_despacho_nombre)



                                                                            if @bus_lugar_despacho == nil
                                                                              puts "***********EL NOMBRE DE DESPACHO NO EXISTE*****************************".yellow





                                                                              #Busqueda de vendedor
                                                                              vendedor_nombre = spreadsheet.cell(14,'C').to_s.upcase
                                                                              puts "******************nombre vendedor: #{vendedor_nombre}**********************".green
                                                                                        if vendedor_nombre.length > 0
                                                                                          puts "*****************vendedor existe***********************".green
                                                                                          vendedor = User.find_by(nombre: vendedor_nombre)
                                                                                                    if vendedor == nil
                                                                                                      puts "******************VENDEDOR NO EXISTE**********************".red

                                                                                                    else

                                                                                                      puts "******************VENDEDOR EXISTE**********************".yellow
                                                                                                      puts "**************CREACION DEL CONTACTO**************************".yellow
                                                                                                      puts "**************CLIENTE ID: #{cliente_id}**************************".blue
                                                                                                      puts "**************VENDEDOR ID: #{vendedor.id}**************************".blue
                                                                                                      puts "**************facturar_a: #{lugar_despacho_nombre}**************************".blue
                                                                                                      lugar_despachoNuevo = LugarDespacho.new(direccion: lugar_despacho_nombre,cliente_id:cliente_id)
                                                                                                      if lugar_despachoNuevo.save
                                                                                                          puts "************** El lugar despacho ha sido creado **************************".green
                                                                                                          @lugar_despacho_id=lugar_despachoNuevo.id
                                                                                                      end

                                                                                                    end
                                                                                        else
                                                                                          puts "****************STRING VENDEDOR VACIO************************".red
                                                                                        end











                                                                            else
                                                                              puts "**************el lugar despacho Existe**************************".green
                                                                                @lugar_despacho_id=@bus_lugar_despacho.id
                                                                            end
                                                            else
                                                                    puts "**************La El campo lugar despachos esta vacio**************************"
                                                                    busqueda = "SIN DEFINIR"
                                                                    @bus_lugar_despacho = LugarDespacho.find_by(direccion: busqueda)
                                                                    puts "**************Busqueda De la linea_producto nulas**************************"


                                                                              if @bus_lugar_despacho == nil

                                                                              else
                                                                                  @lugar_despacho_id = @bus_lugar_despacho.id
                                                                              end
                                                            end


                                                            puts "****************¡¡¡¡LOS DATOS NECESARIOS EXISTEN???????************************".blue
                                                            puts "****************CONTACTO: #{@contacto_id}************************".green
                                                            puts "****************FACTURAR A: #{@facturar_a_id}************************".green
                                                            puts "****************LUGAR DESPACHO ID: #{@lugar_despacho_id}************************".green


                                                            if @contacto_id.present? && @facturar_a_id.present? && @lugar_despacho_id.present?
                                                              puts "****************LOS DATOS NECESARIOS EXISTEN************************".blue
                                                              puts "****************CONTACTO: #{@contacto_id}************************".green
                                                              puts "****************FACTURAR A: #{@facturar_a_id}************************".green
                                                              puts "****************LUGAR DESPACHO ID: #{@lugar_despacho_id}************************".green

                                                              orden_de_compra = spreadsheet.cell(10,'L').to_s.upcase
                                                              cantidad_solicitada = spreadsheet.cell(11,'L')
                                                              cantidad_hoja = spreadsheet.cell(21,'B')
                                                              tamanos_totales_op = spreadsheet.cell(22,'K')
                                                              obs= spreadsheet.cell(63,'C')
                                                              obs2 = spreadsheet.cell(64,'A')
                                                              obs3 = spreadsheet.cell(65,'A')
                                                              obs4 = spreadsheet.cell(66,'A')
                                                              observacion = obs.to_s + "\n" + obs2.to_s + "\n" + obs3.to_s + "\n" + obs4

                                                              puts "================VALOR 1========================".yellow
                                                              puts "******************#{tamanos_totales_op}**********************".blue
                                                              puts "========================================".yellow
                                                              cavidad = spreadsheet.cell(21,'G')
                                                              cantidad_programada = tamanos_totales_op.to_f * cavidad.to_f

                                                              puts "=================VALOR 2=======================".yellow
                                                              puts "******************#{tamanos_totales_op}**********************".blue
                                                              puts "========================================".yellow
                                                              fecha = fecha_de_orden
                                                              sacar_de_inventario = inventario
                                                              habilitar_impresion = true
                                                              if inventario == true
                                                                habilitar_impresion =false
                                                              end
                                                              precio_unitario = spreadsheet.cell(13,'D')
                                                              ordenCreada = OrdenProduccion.new(numero_de_orden:numero_op,precio_unitario:precio_unitario,habilitar_impresion:habilitar_impresion,sacar_de_inventario:sacar_de_inventario,fecha:fecha,observacion:observacion,cantidad_programada:cantidad_programada,cavidad:cavidad,tamanos_total:tamanos_totales_op,cantidad_hoja:cantidad_hoja,cantidad_solicitada:cantidad_solicitada,orden_de_compra:orden_de_compra,montaje_id: montajeNuevo.id, contacto_id: @contacto_id, nombre_facturacion_id:@facturar_a_id, lugar_despacho_id:@lugar_despacho_id)
                                                              if ordenCreada.save
                                                                puts "*****************ORDEN DE PRODUCCION***********************".green
                                                                if fecha_compromiso.present?
                                                                  puts "******************LA FECHA DE COMPROISO EXITES Y ES #{fecha_compromiso}**********************".yellow
                                                                  compromisos_de_entrega = CompromisoDeEntrega.new(orden_produccion_id:ordenCreada.id,fecha_de_compromiso:fecha_compromiso, cantidad:cantidad_solicitada)
                                                                  if compromisos_de_entrega.save
                                                                    puts "*******************COMPROMISO DE ENTREGA CREADO*********************".green
                                                                  end
                                                                end
                                                              end
                                                            else
                                                            end
















                                         #busqueda de maquinas para contenedor
                                         puts "*******************SESION DE MAQUINAS*********************"


                                         maquinas_id = []
                                         if maquinas_seleccionadas.present?
                                           maquinas_id = maquinas_seleccionadas
                                         else
                                               nombre_maquina = spreadsheet.cell(6,'J').to_s.upcase
                                               puts "******************maquina: #{nombre_maquina}**********************".blue

                                               nombre_maquina = nombre_maquina.split(", ")

                                              puts "******************ARRAY maquina: #{nombre_maquina}**********************".blue

                                               nombre_maquina.each do |machine|


                                                     consultar_maquina = Maquina.find_by(nombre:machine)
                                                     if consultar_maquina == nil
                                                          puts "*****************LA MAQUINA NO EXISTE***********************".red
                                                     else

                                                          puts "*****************LA MAQUINA EXISTE***********************".green
                                                          maquinas_id << consultar_maquina.id
                                                     end



                                               end
                                         end
                                         puts "****************INSERCION CONTENEDOR DE MAQUINAS************************"
                                         #INSERCION CONTENEDOR MAQUINA
                                         maquinas_id.each do |crear|
                                           puts "*****************id maquina: #{crear}***********************".blue
                                           contenedor_para_maquinas= ContenedorDeMaquinas.new(montaje_id:montajeNuevo.id,maquina_id:crear)
                                          if contenedor_para_maquinas.save
                                            puts "****************CONTENEDOR DE MAQUINAS CREADO************************".green
                                          end



                                         end



                                         puts "*******************SESION DE TINTAS*********************"


                                         #TINTAS PARA DESARROLLO 1
                                         descripcion_de_tinta = spreadsheet.cell(28,'E').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'E').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'E').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end

                                         #TINTAS PARA DESARROLLO 2
                                         descripcion_de_tinta = spreadsheet.cell(28,'F').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'F').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'F').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end











                                         #TINTAS PARA DESARROLLO 3
                                         descripcion_de_tinta = spreadsheet.cell(28,'G').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'G').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'G').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end














                                         #TINTAS PARA DESARROLLO 4
                                         descripcion_de_tinta = spreadsheet.cell(28,'H').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'H').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'H').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end








                                         #TINTAS PARA DESARROLLO 5
                                         descripcion_de_tinta = spreadsheet.cell(28,'I').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'I').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'I').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end







                                         #TINTAS PARA DESARROLLO 6
                                         descripcion_de_tinta = spreadsheet.cell(28,'J').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'J').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'J').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end
















                                         #TINTAS PARA DESARROLLO 7
                                         descripcion_de_tinta = spreadsheet.cell(28,'K').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'K').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'K').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end














                                         #TINTAS PARA DESARROLLO 8
                                         descripcion_de_tinta = spreadsheet.cell(28,'L').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'L').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'L').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end








                                         #TINTAS PARA DESARROLLO 9
                                         descripcion_de_tinta = spreadsheet.cell(28,'L').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0
                                           puts "******************LA TINTA EXISTE**********************".yellow
                                                             #CONSULTA DE MALLA
                                                             nombre_malla = spreadsheet.cell(29,'L').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = Malla.new(nombre: nombre_malla)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                malla_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              malla_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = Malla.new(nombre: indefinido)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                malla_id = malla_indefinida.id
                                                                            end
                                                             end




                                                             #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                             nombre_malla = spreadsheet.cell(27,'L').to_s.upcase
                                                             if nombre_malla.length > 0
                                                                            puts "********************MALLA EXISTE********************".green
                                                                            consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                            if consulta_malla == nil
                                                                              puts "*******************LA MALLA NO EXISTE*********************".red
                                                                              crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                              if crearMalla.save
                                                                                puts "*********************MALLA CREADA*******************"
                                                                                linea_id = crearMalla.id
                                                                              else
                                                                                puts "******************MALLA NO SALVADA**********************".red
                                                                              end
                                                                            else
                                                                              puts "*******************LA MALLA EXISTE*********************".green
                                                                              linea_id= consulta_malla.id
                                                                            end
                                                             else
                                                                            puts "********************MALLA NO EXISTE********************".red
                                                                            indefinido = "SIN DEFINIR"
                                                                            malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                            if malla_indefinida == nil
                                                                                puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                if crearMalla.save
                                                                                  puts "******************MALLA CREADA**********************".green
                                                                                  linea_id = crearMalla.id
                                                                                else
                                                                                  puts "******************MALLA NO SALVADA**********************".red
                                                                                end
                                                                            else
                                                                                puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                linea_id = malla_indefinida.id
                                                                            end
                                                             end


                                                             #INSERCION EN EL DESARROLLO DE LA TINTA
                                                             tiro = true
                                                             retiro = false
                                                             crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                             if crearTinta.save
                                                                puts "*****************TINTAS GUARDADA***********************".green
                                                             else
                                                                puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                             end
                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end











                                         #TINTAS PARA DESARROLLO RETIRO 1
                                         descripcion_de_tinta = spreadsheet.cell(33,'E').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'E').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'E').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end














                                         #TINTAS PARA DESARROLLO RETIRO 2
                                         descripcion_de_tinta = spreadsheet.cell(33,'F').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'F').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'F').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end









                                         #TINTAS PARA DESARROLLO RETIRO 3
                                         descripcion_de_tinta = spreadsheet.cell(33,'G').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'G').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'G').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end















                                         #TINTAS PARA DESARROLLO RETIRO 4
                                         descripcion_de_tinta = spreadsheet.cell(33,'H').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'H').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'H').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end
















                                         #TINTAS PARA DESARROLLO RETIRO 5
                                         descripcion_de_tinta = spreadsheet.cell(33,'I').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'I').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'I').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end





                                         #TINTAS PARA DESARROLLO RETIRO 6
                                         descripcion_de_tinta = spreadsheet.cell(33,'J').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'J').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'J').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end












                                         #TINTAS PARA DESARROLLO RETIRO 7
                                         descripcion_de_tinta = spreadsheet.cell(33,'K').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'K').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'K').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end






                                         #TINTAS PARA DESARROLLO RETIRO 8
                                         descripcion_de_tinta = spreadsheet.cell(33,'L').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'L').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'L').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end























                                         #TINTAS PARA DESARROLLO RETIRO 9
                                         descripcion_de_tinta = spreadsheet.cell(33,'M').to_s.upcase
                                         puts "******************LA TINTA ES: #{descripcion_de_tinta}**********************".yellow

                                         if descripcion_de_tinta.length > 0




                                                puts "**************BUSQUEDA DE LA TINTA EN EL TIRO**************************".green

                                                buscar_tinta_retiro = DesarrolloDeTinta.find_by(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id)


                                                if buscar_tinta_retiro == nil





                                                               puts "******************LA TINTA EXISTE**********************".yellow
                                                                                 #CONSULTA DE MALLA
                                                                                 nombre_malla = spreadsheet.cell(34,'M').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = Malla.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = Malla.new(nombre: nombre_malla)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    malla_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  malla_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = Malla.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = Malla.new(nombre: indefinido)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    malla_id = malla_indefinida.id
                                                                                                end
                                                                                 end




                                                                                 #CONSULTA DE LINEA PARA DESARROLLO DE TINTAS
                                                                                 nombre_malla = spreadsheet.cell(32,'M').to_s.upcase
                                                                                 if nombre_malla.length > 0
                                                                                                puts "********************MALLA EXISTE********************".green
                                                                                                consulta_malla = LineaDeColor.find_by(nombre: nombre_malla)
                                                                                                if consulta_malla == nil
                                                                                                  puts "*******************LA MALLA NO EXISTE*********************".red
                                                                                                  crearMalla = LineaDeColor.new(nombre: nombre_malla, estado: false)
                                                                                                  if crearMalla.save
                                                                                                    puts "*********************MALLA CREADA*******************"
                                                                                                    linea_id = crearMalla.id
                                                                                                  else
                                                                                                    puts "******************MALLA NO SALVADA**********************".red
                                                                                                  end
                                                                                                else
                                                                                                  puts "*******************LA MALLA EXISTE*********************".green
                                                                                                  linea_id= consulta_malla.id
                                                                                                end
                                                                                 else
                                                                                                puts "********************MALLA NO EXISTE********************".red
                                                                                                indefinido = "SIN DEFINIR"
                                                                                                malla_indefinida = LineaDeColor.find_by(nombre: indefinido)
                                                                                                if malla_indefinida == nil
                                                                                                    puts "***************NO EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    crearMalla = LineaDeColor.new(nombre: indefinido, estado: false)
                                                                                                    if crearMalla.save
                                                                                                      puts "******************MALLA CREADA**********************".green
                                                                                                      linea_id = crearMalla.id
                                                                                                    else
                                                                                                      puts "******************MALLA NO SALVADA**********************".red
                                                                                                    end
                                                                                                else
                                                                                                    puts "***************SI EXISTE LA MALLA SIN DEFINIR*************************".yellow
                                                                                                    linea_id = malla_indefinida.id
                                                                                                end
                                                                                 end


                                                                                 #INSERCION EN EL DESARROLLO DE LA TINTA
                                                                                 tiro = false
                                                                                 retiro = true
                                                                                 crearTinta = DesarrolloDeTinta.new(descripción: descripcion_de_tinta, montaje_id: montajeNuevo.id,malla_id:malla_id, linea_de_color_id:linea_id, tiro: tiro, retiro: retiro)
                                                                                 if crearTinta.save
                                                                                    puts "*****************TINTAS GUARDADA***********************".green
                                                                                 else
                                                                                    puts "*****************ERROR AL SALVAR LA TINTA***********************".red
                                                                                 end


                                                else

                                                      puts "*************************SI EXISTE EN EL TIRO***************".green
                                                      chance_retiro = true
                                                      buscar_tinta_retiro.update(retiro: chance_retiro)
                                                end

                                         else
                                                      puts "******************LA TINTA NO EXISTE**********************".red
                                         end


















                                    else
                                         puts "*******************FALLA EN LA INSERCION DEL MONTAJE*********************".red
                                    end
                            else
                                    puts "**************MONTAJE EXISTE**************************".green
                                    #busqueda de ORDENES
                                    puts "*******************SESION DE ORDENES*********************"

                                    #busquea de contactos
                                    contacto_nombre = spreadsheet.cell(10,'B').to_s.upcase
                                    puts "***************Crear contacto - <(*) #{contacto_nombre} (*)> - para orden************************".green

                                                if contacto_nombre.length != 0
                                                      @bus_contacto= Contacto.find_by(nombre_contacto: contacto_nombre)
                                                      puts "**************Busqueda Del contacto**************************".red


                                                                if @bus_contacto == nil
                                                                puts "******************EL CONTACTO NO EXISTE**********************".red





                                                                  #Busqueda de vendedor
                                                                  if comercial_id.present?
                                                                    puts "*******************EL COMERCIAL HA SIDO SELECCIONADO*********************".green
                                                                    contactoNuevo = Contacto.new(nombre_contacto: contacto_nombre,cliente_id:cliente_id, user_id: comercial_id)
                                                                    if contactoNuevo.save
                                                                        puts "************** El contacto ha sido creado **************************".green
                                                                        @contacto_id=contactoNuevo.id
                                                                    end

                                                                  else
                                                                    puts "*******************EL COMERCIAL NO HA SIDO SELECCIONADO*********************".red


                                                                                    vendedor_nombre = spreadsheet.cell(14,'C').to_s.upcase
                                                                                    puts "******************nombre vendedor: #{vendedor_nombre}**********************".green
                                                                                              if vendedor_nombre.length > 0
                                                                                                puts "*****************vendedor existe***********************".green
                                                                                                vendedor = User.find_by(nombre: vendedor_nombre)
                                                                                                          if vendedor == nil
                                                                                                            puts "******************VENDEDOR NO EXISTE**********************".red

                                                                                                          else

                                                                                                                      puts "******************VENDEDOR EXISTE**********************".yellow
                                                                                                                      puts "**************CREACION DEL CONTACTO**************************".yellow
                                                                                                                      puts "**************CLIENTE ID: #{cliente_id}**************************".blue
                                                                                                                      puts "**************VENDEDOR ID: #{vendedor.id}**************************".blue
                                                                                                                      puts "**************NOMBRE CONTACTO: #{contacto_nombre}**************************".blue
                                                                                                                      contactoNuevo = Contacto.new(nombre_contacto: contacto_nombre,cliente_id:cliente_id, user_id: vendedor.id)
                                                                                                                      if contactoNuevo.save
                                                                                                                          puts "************** El contacto ha sido creado **************************".green
                                                                                                                          @contacto_id=contactoNuevo.id
                                                                                                                      end

                                                                                                          end
                                                                                              else
                                                                                                puts "****************STRING VENDEDOR VACIO************************".red
                                                                                              end


                                                                         end








                                                                else
                                                                  puts "**************EL CONTACTO  EXISTE**************************".green
                                                                    @contacto_id=@bus_contacto.id
                                                                end
                                                else
                                                        puts "**************La El campo contacto esta vacio**************************"
                                                        busqueda = "SIN DEFINIR"
                                                        @bus_contacto = Contacto.find_by(nombre_contacto: busqueda)
                                                        puts "**************Busqueda De la linea_producto nulas**************************"


                                                                  if @bus_contacto== nil

                                                                  else
                                                                      @contacto_id=@bus_contacto.id
                                                                  end
                                                end


                                                       #busqueda nombre facturacion
                                                       facturar_a_nombre= spreadsheet.cell(8,'H').to_s.upcase
                                                       puts "*************** Facturar a - <(*) #{facturar_a_nombre} (*)> - para orden************************".green

                                                       if facturar_a_nombre.length != 0

                                                             puts "**************Busqueda Del Facturado**************************".red
                                                             @bus_facturar_a = NombreFacturacion.find_by(nombre: facturar_a_nombre)



                                                                       if @bus_facturar_a == nil
                                                                         puts "***********EL NOMBRE DE FACTURACION NO EXISTE*****************************".yellow





                                                                         #Busqueda de vendedor
                                                                         vendedor_nombre = spreadsheet.cell(14,'C').to_s.upcase
                                                                         puts "******************nombre vendedor: #{vendedor_nombre}**********************".green
                                                                                   if vendedor_nombre.length > 0
                                                                                     puts "*****************vendedor existe***********************".green
                                                                                     vendedor = User.find_by(nombre: vendedor_nombre)
                                                                                               if vendedor == nil
                                                                                                 puts "******************VENDEDOR NO EXISTE**********************".red

                                                                                               else

                                                                                                 puts "******************VENDEDOR EXISTE**********************".yellow
                                                                                                 puts "**************CREACION DEL CONTACTO**************************".yellow
                                                                                                 puts "**************CLIENTE ID: #{cliente_id}**************************".blue
                                                                                                 puts "**************VENDEDOR ID: #{vendedor.id}**************************".blue
                                                                                                 puts "**************facturar_a: #{facturar_a_nombre}**************************".blue
                                                                                                 facturar_aNuevo = NombreFacturacion.new(nombre: facturar_a_nombre,cliente_id:cliente_id)
                                                                                                 if facturar_aNuevo.save
                                                                                                     puts "************** El contacto ha sido creado **************************".green
                                                                                                     @facturar_a_id=facturar_aNuevo.id
                                                                                                 end

                                                                                               end
                                                                                   else
                                                                                     puts "****************STRING VENDEDOR VACIO************************".red
                                                                                   end











                                                                       else
                                                                         puts "*************la factura existe Existe**************************".green
                                                                           @facturar_a_id=@bus_facturar_a.id
                                                                       end


                                                       else
                                                               puts "**************La El campo contacto esta vacio**************************"
                                                               busqueda = "SIN DEFINIR"
                                                               @bus_facturar_a = NombreFacturacion.find_by(nombre: busqueda)
                                                               puts "**************Busqueda De la facturacion nulas**************************"


                                                                         if @bus_facturar_a== nil

                                                                         else
                                                                             @facturar_a_id = @bus_facturar_a.id
                                                                         end
                                                       end









                                                       #lugar a despachar
                                                       lugar_despacho_nombre= spreadsheet.cell(9,'B').to_s.upcase
                                                       puts "*************** Facturar a - <(*) #{lugar_despacho_nombre} (*)> - para orden************************".green

                                                       if lugar_despacho_nombre.length != 0

                                                             puts "**************Busqueda Del lUGAR DESPACHO**************************".red
                                                             @bus_lugar_despacho = LugarDespacho.find_by(direccion: lugar_despacho_nombre)



                                                                       if @bus_lugar_despacho == nil
                                                                         puts "***********EL NOMBRE DE DESPACHO NO EXISTE*****************************".yellow





                                                                         #Busqueda de vendedor
                                                                         vendedor_nombre = spreadsheet.cell(14,'C').to_s.upcase
                                                                         puts "******************nombre vendedor: #{vendedor_nombre}**********************".green
                                                                                   if vendedor_nombre.length > 0
                                                                                     puts "*****************vendedor existe***********************".green
                                                                                     vendedor = User.find_by(nombre: vendedor_nombre)
                                                                                               if vendedor == nil
                                                                                                 puts "******************VENDEDOR NO EXISTE**********************".red

                                                                                               else

                                                                                                 puts "******************VENDEDOR EXISTE**********************".yellow
                                                                                                 puts "**************CREACION DEL CONTACTO**************************".yellow
                                                                                                 puts "**************CLIENTE ID: #{cliente_id}**************************".blue
                                                                                                 puts "**************VENDEDOR ID: #{vendedor.id}**************************".blue
                                                                                                 puts "**************facturar_a: #{lugar_despacho_nombre}**************************".blue
                                                                                                 lugar_despachoNuevo = LugarDespacho.new(direccion: lugar_despacho_nombre,cliente_id:cliente_id)
                                                                                                 if lugar_despachoNuevo.save
                                                                                                     puts "************** El lugar despacho ha sido creado **************************".green
                                                                                                     @lugar_despacho_id=lugar_despachoNuevo.id
                                                                                                 end

                                                                                               end
                                                                                   else
                                                                                     puts "****************STRING VENDEDOR VACIO************************".red
                                                                                   end











                                                                       else
                                                                         puts "**************el lugar despacho Existe**************************".green
                                                                           @lugar_despacho_id=@bus_lugar_despacho.id
                                                                       end
                                                       else
                                                               puts "**************La El campo lugar despachos esta vacio**************************"
                                                               busqueda = "SIN DEFINIR"
                                                               @bus_lugar_despacho = LugarDespacho.find_by(direccion: busqueda)
                                                               puts "**************Busqueda De la linea_producto nulas**************************"


                                                                         if @bus_lugar_despacho == nil

                                                                         else
                                                                             @lugar_despacho_id = @bus_lugar_despacho.id
                                                                         end
                                                       end




                                                       if @contacto_id.present? && @facturar_a_id.present? && @lugar_despacho_id.present?
                                                         puts "****************LOS DATOS NECESARIOS EXISTEN************************".blue
                                                         puts "****************CONTACTO: #{@contacto_id}************************".green
                                                         puts "****************FACTURAR A: #{@facturar_a_id}************************".green
                                                         puts "****************LUGAR DESPACHO ID: #{@lugar_despacho_id}************************".green

                                                         orden_de_compra = spreadsheet.cell(10,'L').to_s.upcase
                                                         cantidad_solicitada = spreadsheet.cell(11,'L')
                                                         cantidad_hoja = spreadsheet.cell(21,'B')
                                                         tamanos_totales_op = spreadsheet.cell(22,'K')
                                                         obs= spreadsheet.cell(63,'C')
                                                         obs2 = spreadsheet.cell(64,'A')
                                                         obs3 = spreadsheet.cell(65,'A')
                                                         obs4 = spreadsheet.cell(66,'A')
                                                         observacion = obs.to_s + "\n" + obs2.to_s + "\n" + obs3.to_s + "\n" + obs4

                                                         puts "================VALOR 1========================".yellow
                                                         puts "******************#{tamanos_totales_op}**********************".blue
                                                         puts "========================================".yellow
                                                         cavidad = spreadsheet.cell(21,'G')
                                                         cantidad_programada = tamanos_totales_op.to_f * cavidad.to_f

                                                         puts "=================VALOR 2=======================".yellow
                                                         puts "******************#{tamanos_totales_op}**********************".blue
                                                         puts "========================================".yellow
                                                         fecha = fecha_de_orden
                                                         sacar_de_inventario = inventario
                                                         habilitar_impresion = true
                                                         if inventario == true
                                                           habilitar_impresion =false
                                                         end
                                                         precio_unitario = spreadsheet.cell(13,'D')
                                                         ordenCreada = OrdenProduccion.new(numero_de_orden:numero_op,precio_unitario:precio_unitario,habilitar_impresion:habilitar_impresion,sacar_de_inventario:sacar_de_inventario,fecha:fecha,observacion:observacion,cantidad_programada:cantidad_programada,cavidad:cavidad,tamanos_total:tamanos_totales_op,cantidad_hoja:cantidad_hoja,cantidad_solicitada:cantidad_solicitada,orden_de_compra:orden_de_compra,montaje_id: montaje.id, contacto_id: @contacto_id, nombre_facturacion_id:@facturar_a_id, lugar_despacho_id:@lugar_despacho_id)
                                                         if ordenCreada.save
                                                           puts "*****************ORDEN DE PRODUCCION***********************".green
                                                           if fecha_compromiso.present?
                                                             puts "******************LA FECHA DE COMPROISO EXITES Y ES #{fecha_compromiso}**********************".yellow
                                                             compromisos_de_entrega = CompromisoDeEntrega.new(orden_produccion_id:ordenCreada.id,fecha_de_compromiso:fecha_compromiso, cantidad:cantidad_solicitada)
                                                             if compromisos_de_entrega.save
                                                               puts "*******************COMPROMISO DE ENTREGA CREADO*********************".green
                                                             end
                                                           end
                                                         end
                                                       else
                                                       end




                            end
                else
                  puts "*****************STRING VACIO***********************".red
                end




          end

        else
          puts "******************* ORDEN EXISTE *********************".green
          @errores << "LA ORDEN DE PRODUCCION YA EXISTE"

          if @errores != []
            return @errores
          else
            return true
          end

        end



      else
        puts "*******************STRING VACIO*********************".blue
      end


  end









end
