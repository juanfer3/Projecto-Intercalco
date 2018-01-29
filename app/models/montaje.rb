class Montaje < ApplicationRecord
  belongs_to :cliente
  belongs_to :user

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

    header = spreadsheet.row(1)
    nombre_cliente =""
    (2..spreadsheet.last_row).each do |i|



      @montaje_nombre = spreadsheet.row(i)[2]
      puts "****************************************"+@montaje_nombre+"**********************"

      @montaje = Montaje.find_by(nombre: @montaje_nombre)





      if @montaje == nil

              puts "****************************************Vacio**********************"
              @nombre_cliente = spreadsheet.row(i)[0]
              puts "****************************************"+@nombre_cliente+"*********************"


              @clientes = Cliente.all

              @clientes.each do |cliente|
                if cliente.nombre == @nombre_cliente
                  @cliente_id=cliente.id
                end
              end

              puts "****************************************Vacio**********************"
              @nombre_user = spreadsheet.row(i)[5]
              puts "****************************************"+@nombre_cliente+"*********************"


              @users = User.all

              @users.each do |user|
                if user.nombre == @nombre_user
                  @user_id=user.id
                end
              end


              formato_op = Montaje.new( codigo:spreadsheet.row(i)[1], nombre: spreadsheet.row(i)[2], cliente_id: @cliente_id, user_id: @user_id)

              if formato_op.save
                puts "**************Montaje Guardado**************************"

                    @mo = Montaje.find_by(nombre: @montaje_nombre)



                          @linea_produccion_nombre = spreadsheet.row(i)[6]
                          puts "==============="+@linea_produccion_nombre+"==============="

                          @lineas_produccion = LineaProducto.all

                          @lineas_produccion.each do |linea_produccion|
                            if linea_produccion.nombre == @linea_produccion_nombre
                              @linea_produccion_id=linea_produccion.id
                              puts "===============l produccion id: "+@linea_produccion_id.to_s+"==============="
                            end
                          end


                          @piezas_a_decorar_nombre = spreadsheet.row(i)[7]

                          @piezas_a_decorar = PiezaADecorar.all

                          @piezas_a_decorar.each do |pieza_a_decorar|
                            if pieza_a_decorar.nombre == @piezas_a_decorar_nombre
                              @pieza_a_decorar_id=pieza_a_decorar.id
                              puts "===============piezas id: "+@pieza_a_decorar_id.to_s+"==============="
                            end
                          end


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

                    formato_op = FormatoOp.new(montaje_id: @mo.id, pieza_a_decorar_id: @pieza_a_decorar_id, maquina_id: @maquina_id, linea_de_color_id: @linea_de_color_id, linea_producto_id:@linea_produccion_id )
                    if formato_op.save
                      puts "*******************Insercion De Formatos*********************"
                    end
                    piezas=Pieza.new( codigo:spreadsheet.row(i)[3], nombre: spreadsheet.row(i)[4], montaje_id: @mo.id)
                    if piezas.save
                      puts "*******************Insercion De piezas*********************"
                    end
              end

      else
            puts "****************************************Lleno**********************"



              piezas=Pieza.new( codigo:spreadsheet.row(i)[3], nombre: spreadsheet.row(i)[4], montaje_id: @montaje.id)

              if piezas.save
                puts "*******************Insercion De piezas*********************"
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
