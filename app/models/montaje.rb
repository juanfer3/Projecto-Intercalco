class Montaje < ApplicationRecord
  belongs_to :cliente
  belongs_to :linea_de_color
  belongs_to :linea_producto
  belongs_to :material

  has_many :formatos_op, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :formatos_op, reject_if: :all_blank, allow_destroy: true

  has_many :piezas , inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :piezas, reject_if: :all_blank, allow_destroy: true

  has_many :tintas_fop_tiro, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :tintas_fop_tiro, reject_if: :all_blank, allow_destroy: true

  has_many :tintas_fop_retiro, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :tintas_fop_retiro, reject_if: :all_blank, allow_destroy: true

  has_many :ordenes_produccion, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :ordenes_produccion, reject_if: :all_blank, allow_destroy: true

  has_many :desarrollos_de_tintas, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :desarrollos_de_tintas, reject_if: :all_blank, allow_destroy: true

  has_many :contenedores_de_acabados, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :contenedores_de_acabados, reject_if: :all_blank, allow_destroy: true


  has_many :acabados, through: :contenedores_de_acabados

  attr_accessor :new_cliente, :select_vendedor, :material_nuevo,
  :contacto_nuevo_montaje, :contacto_creado, :nit_cliente, :dir_cliente,
  :tel_cliente, :tel_contacto, :direccion_nuevo_montaje, :facturar_a_nuevo_montaje,:agregar_acabado

  before_save :create_cliente
  after_save :despues_de_guardar

  def despues_de_guardar
    #code
    if agregar_acabado.present?
      puts "****************Agregar acabado Presente************************"
      mostrar = agregar_acabado.split(", ")

      puts "***************Mostrar: - #{mostrar}*************************"
      for i in 0..mostrar.length-1
        acabado=Acabado.create(nombre:mostrar[i])
        if acabado.save
          puts "****************se almaceno acabado************************"
          contenedor=ContenedorDeAcabados.create(montaje_id:self.id, acabado_id: acabado.id)
          puts "***************Contenedor Creado*************************"if contenedor.save
        end
      end
    end
  end


  def self.buscar_ficha(data)
    #code
    dato= data.to_s.upcase
    puts "*****************Entrada***********************"
    puts "*****************el dato es: #{dato}***********************"
    @fichas= Montaje.where('montajes.codigo ILIKE ?', dato+'%').order("codigo")


    if @fichas.any?
            puts "*****************MOntaje nombre lleno***********************"
            return @fichas
    else
              puts "*****************MOntaje nombre vacio***********************"
              @fichas= Montaje.joins(:cliente).where('clientes.nombre ILIKE ?', dato+'%').order("codigo")


              if @fichas.empty?
                puts "****************Cliente no existe************************"
                @fichas= Montaje.where('montajes.nombre ILIKE ?', '%'+dato+'%').order("codigo")
                if @fichas.empty?
                  puts "****************nombre montaje no existe************************"
                  return @fichas
                else
                  return @fichas
                end
              else



                  puts "****************Cliente existe************************"
                  return @fichas
              end
    end




    @orden= []



#===========================================
  end



  def create_cliente


        if new_cliente.present?
            self.cliente = Cliente.create(nombre: new_cliente, nit: nit_cliente,user_id: select_vendedor)
            contacto_creado = Contacto.create(nombre_contacto: contacto_nuevo_montaje, user_id: select_vendedor, cliente_id: self.cliente.id) if contacto_nuevo_montaje.present?
            facturar = NombreFacturacion.create(cliente_id: self.cliente.id, nombre: facturar_a_nuevo_montaje)if facturar_a_nuevo_montaje.present?
            direcion_entrega = LugarDespacho.create(cliente_id: self.cliente.id, direccion: direccion_nuevo_montaje)if direccion_nuevo_montaje.present?


            if contacto_creado != nil
              puts "****************CONTACTO CREADO************************"
              self.ordenes_produccion.each do |produccion|
                produccion.contacto = contacto_creado
              end
            end
            if facturar != nil
              puts "****************FACTURAR A CREADO************************"
              self.ordenes_produccion.each do |produccion|
                produccion.nombre_facturacion = facturar
              end
            end
            if direcion_entrega != nil
              puts "****************DIRECCION CREADA************************"
              self.ordenes_produccion.each do |produccion|
                produccion.lugar_despacho = direcion_entrega
              end
            end

        end

        self.material = Material.create(descripcion: material_nuevo) if material_nuevo.present?


  end


  def self.subir_montaje_from_excel(file)

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
    nombre_cliente =""
    (2..spreadsheet.last_row).each do |i|



      @nombre_cliente = spreadsheet.row(i)[0]
      puts "****************************************"+nombre_cliente+"*********************"


      @clientes = Cliente.all

      @clientes.each do |cliente|
        if cliente.nombre == @nombre_cliente
          @cliente_id=cliente.id
        end
      end
                #@cliente_b =Cliente.all.where("clientes.nombre='#{nombre_cliente}'")

                #@cliente_b.each do |cli|


                  #puts "****************************************Buscador"+@cliente_id.to_s+"**********************"

                #end

      formato_op = Montaje.new( codigo:spreadsheet.row(i)[1], nombre: spreadsheet.row(i)[2], cliente_id: @cliente_id)

      unless formato_op.save
        cliente.errors.full_messages.each do |message|
          @errores << "Error en la fila #{i}, columna #{message}"
        end
      end





    end

    if @errores != []
      return @errores
    else
      return true
    end

  end


#SUBIR MONTAJES CON PIEZAS
  def self.subir_MP_from_excel(file)

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


    (2..spreadsheet.last_row).each do |i|
      puts "*******************Entra Al excel*********************"
      codigo_de_pieza = spreadsheet.row(i)[3]


      puts "*******************cod pieza #{codigo_de_pieza}*********************"
      if codigo_de_pieza != ""
        puts "*******************La Pieza NO es un String vacio y la pieza es *********************"

            @busq_pieza = Pieza.find_by(codigo: codigo_de_pieza)
            puts "*******************Consulto La Pieza y es *********************"
                    if @busq_pieza == nil
                      puts "****************************************La pieza No Existe**********************"


                                          @montaje_nombre = spreadsheet.row(i)[2].to_s.upcase
                                          puts "****************************************NOmbre: Montaje"+@montaje_nombre+"**********************"

                                          @montaje = Montaje.find_by(nombre: @montaje_nombre)





                                          if @montaje == nil

                                                  puts "****************************************El Montaje No Existe**********************"
                                                  @nombre_cliente = spreadsheet.row(i)[0].to_s.upcase
                                                  puts "****************************************"+@nombre_cliente+"*********************"
                                                  @cli = Cliente.find_by(nombre: @nombre_cliente)
                                                  puts "****************************************Busco El cliente**********************"
                                                  if @cli == nil
                                                    puts "****************************************El Cliente no Existe**********************"
                                                    @nombre_user = spreadsheet.row(i)[5]

                                                    @vendedor=User.find_by(nombre: @nombre_user)
                                                    puts "****************************************El Vendedor es #{@vendedor.nombre}**********************"
                                                    @clienteNuevo=Cliente.new(nombre:spreadsheet.row(i)[0],user_id:@vendedor.id)
                                                    if @clienteNuevo.save
                                                      puts "*****************El Cliente se creo"
                                                    end
                                                    @cliente_id = @clienteNuevo.id
                                                  else
                                                    puts "****************************************El Cliente -Si- Existe y su id es: #{@cli.id}**********************"
                                                    @cliente_id = @cli.id


                                                  end




                                                              @linea_produccion_nombre = spreadsheet.row(i)[6].to_s.upcase
                                                              puts "=============Esta es la Linea==#{@linea_produccion_nombre}==============="

                                                              @lineas_produccion = LineaProducto.find_by(nombre: @linea_produccion_nombre)
                                                              puts "===============se busco linea de producto y es #{@lineas_produccion}==============="

                                                              if @lineas_produccion != nil
                                                                puts "********************La linea existe********************"
                                                                @linea_produccion_id=@lineas_produccion.id
                                                              else
                                                                puts "********************La linea no existe********************"
                                                                linea = LineaProducto.new(nombre: @linea_produccion_nombre)
                                                                if linea.save
                                                                  puts "******************Se creo la linea produccion**********************"
                                                                  @linea_produccion_id=linea.id
                                                                end

                                                              end
















                                                              @linea_de_color_nombre = spreadsheet.row(i)[9].to_s.upcase

                                                              @lineas_de_colores = LineaDeColor.find_by(nombre: @linea_de_color_nombre)


                                                              if @lineas_de_colores != nil
                                                                puts "********************Los colores existe********************"
                                                                @linea_de_color_id=@lineas_de_colores.id
                                                              else
                                                                puts "********************Los colores no existe********************"
                                                                color = LineaDeColor.new(nombre: @linea_de_color_nombre)
                                                                if color.save
                                                                  puts "******************Se creo el color produccion**********************"
                                                                  @linea_de_color_id=color.id
                                                                end

                                                              end


                                                            material_nombre = spreadsheet.row(i)[7].to_s.upcase
                                                            puts "****************buscando materiales************************"
                                                            material = Material.find_by(descripcion:material_nombre)

                                                            if material == nil
                                                              material_save = Material.new(codigo:"POR DEFINIR",descripcion:material_nombre)
                                                              @material_id=material_save.id
                                                            else
                                                              @material_id=material.id
                                                            end

                                                            codigo_mo=spreadsheet.row(i)[1].to_s.upcase
                                                            nombre_mo=spreadsheet.row(i)[2].to_s.upcase
                                                            formato_mo = Montaje.new( codigo:codigo_mo, nombre: nombre_mo, cliente_id: @cliente_id,  linea_de_color_id: @linea_de_color_id, linea_producto_id:@linea_produccion_id, material_id: @material_id)

                                                            if formato_mo.save
                                                              puts "****************************************Montaje Creado**********************"
                                                              codigo_pieza = spreadsheet.row(i)[3].to_s.upcase
                                                              nombre_pieza = spreadsheet.row(i)[4].to_s.upcase
                                                              piezas=Pieza.new( codigo:codigo_pieza, nombre: nombre_pieza, montaje_id: formato_mo.id)

                                                              if piezas.save
                                                                puts "*******************Insercion De piezas*********************"
                                                              end
                                                            end



                                          else
                                                puts "****************************************Lleno**********************"


                                                codigo_pieza = spreadsheet.row(i)[3].to_s.upcase
                                                nombre_pieza = spreadsheet.row(i)[4].to_s.upcase
                                                piezas=Pieza.new( codigo:codigo_pieza, nombre: nombre_pieza, montaje_id: @montaje.id)
                                                  if piezas.save
                                                    puts "*******************Insercion De piezas*********************"
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





end
