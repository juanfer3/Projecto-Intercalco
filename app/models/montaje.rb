class Montaje < ApplicationRecord
  belongs_to :cliente
  belongs_to :linea_de_color
  belongs_to :maquina
  belongs_to :linea_producto

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

  has_many :compromisos_de_entrega, inverse_of: :orden_produccion, dependent: :destroy
  accepts_nested_attributes_for :compromisos_de_entrega, reject_if: :all_blank, allow_destroy: true

  has_many :desarrollos_de_tintas, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :desarrollos_de_tintas, reject_if: :all_blank, allow_destroy: true


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
      codigo_de_p = spreadsheet.row(i)[3].to_s.upcase
      codigo_de_pieza= codigo_de_p

      puts "*******************cod pieza #{codigo_de_pieza}*********************"
      if codigo_de_pieza != ""
        puts "*******************La Pieza NO es un String vacio y la pieza es "+codigo_de_pieza.to_s+"*********************"

            @busq_pieza = Pieza.find_by(codigo: codigo_de_pieza)
            puts "*******************Consulto La Pieza y es *********************"
                    if @busq_pieza == nil
                      puts "****************************************La pieza No Existe**********************"


                                          @montaje_nombre = spreadsheet.row(i)[2].to_s.upcase
                                          puts "****************************************NOmbre: MOntaje"+@montaje_nombre+"**********************"

                                          @montaje = Montaje.find_by(nombre: @montaje_nombre)





                                          if @montaje == nil

                                                  puts "****************************************El Montaje No Existe**********************"
                                                  @nombre_cliente = spreadsheet.row(i)[0]
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

                                                    @nombre_user = spreadsheet.row(i)[5]
                                                    @users = User.find_by(nombre: @nombre_user)
                                                    puts "****************************************El Vendedor se Busco**********************"


                                                        @user_id=@users.id
                                                        puts "****************************************El User -Si- Existe y su id es: #{@users.id}**********************"

                                                  end




                                                              @linea_produccion_nombre = spreadsheet.row(i)[6]
                                                              puts "=============Esta es la LInea==#{@linea_produccion_nombre}==============="

                                                              @lineas_produccion = LineaProducto.find_by(nombre: @linea_produccion_nombre)
                                                              puts "===============se busco linea de producto y es #{@lineas_produccion.id}==============="


                                                                  @linea_produccion_id=@lineas_produccion.id






                                                              @maquinas_nombre = spreadsheet.row(i)[8]
                                                              @maquinas = Maquina.all

                                                              @maquinas.each do |maquina|
                                                                if maquina.nombre == @maquinas_nombre
                                                                  @maquina_id=maquina.id
                                                                  puts "===============maquina id: "+@maquina_id.to_s+"==============="
                                                                end
                                                              end


                                                              @linea_de_color_nombre = spreadsheet.row(i)[9]

                                                              @lineas_de_colores = LineaDeColor.all

                                                              @lineas_de_colores.each do |linea_de_color|
                                                                if linea_de_color.nombre == @linea_de_color_nombre
                                                                  @linea_de_color_id=linea_de_color.id
                                                                  puts "===============color id:"+@linea_de_color_id.to_s+"==============="
                                                                end
                                                              end

                                                            codigo_mo=spreadsheet.row(i)[1].to_s.upcase
                                                            nombre_mo=spreadsheet.row(i)[2].to_s.upcase
                                                            formato_mo = Montaje.new( codigo:codigo_mo, nombre: nombre_mo, cliente_id: @cliente_id, maquina_id: @maquina_id, linea_de_color_id: @linea_de_color_id, linea_producto_id:@linea_produccion_id)
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
