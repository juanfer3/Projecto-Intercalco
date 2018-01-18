class FormatoOp < ApplicationRecord
  belongs_to :user
  belongs_to :maquina
  belongs_to :montaje, dependent: :destroy
  belongs_to :pieza_a_decorar
  belongs_to :linea_de_color
  belongs_to :linea_producto

  has_many :ordenes_produccion, inverse_of: :formato_op, dependent: :destroy
  accepts_nested_attributes_for :ordenes_produccion, reject_if: :all_blank, allow_destroy: true




  def self.subir_fop_from_excel(file)

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



      @vendedor_nombre = spreadsheet.row(i)[3]
      puts "==============="+@vendedor_nombre+"==============="

      @users = User.all

      @users.each do |usuario|
        if usuario.nombre == @vendedor_nombre
          @usuario_id=usuario.id
          puts "===============user "+@usuario_id.to_s+"==============="
        end
      end

      @montaje_nombre = spreadsheet.row(i)[2]

      @montajes = Montaje.all

      @montajes.each do |montaje|
        if montaje.nombre == @montaje_nombre
          @montaje_id=montaje.id
          puts "===============montaje id: "+@montaje_id.to_s+"==============="
        end
      end


      @linea_produccion_nombre = spreadsheet.row(i)[4]
      puts "==============="+@linea_produccion_nombre+"==============="

      @lineas_produccion = LineaProducto.all

      @lineas_produccion.each do |linea_produccion|
        if linea_produccion.nombre == @linea_produccion_nombre
          @linea_produccion_id=linea_produccion.id
          puts "===============l produccion id: "+@linea_produccion_id.to_s+"==============="
        end
      end


      @piezas_a_decorar_nombre = spreadsheet.row(i)[5]

      @piezas_a_decorar = PiezaADecorar.all

      @piezas_a_decorar.each do |pieza_a_decorar|
        if pieza_a_decorar.nombre == @piezas_a_decorar_nombre
          @pieza_a_decorar_id=pieza_a_decorar.id
          puts "===============piezas id: "+@pieza_a_decorar_id.to_s+"==============="
        end
      end


      @maquinas_nombre = spreadsheet.row(i)[6]
      @maquinas = Maquina.all

      @maquinas.each do |maquina|
        if maquina.nombre == @maquinas_nombre
          @maquina_id=maquina.id
          puts "===============maquina id: "+@maquina_id.to_s+"==============="
        end
      end


      @linea_de_color_nombre = spreadsheet.row(i)[7]

      @lineas_de_colores = LineaDeColor.all

      @lineas_de_colores.each do |linea_de_color|
        if linea_de_color.nombre == @linea_de_color_nombre
          @linea_de_color_id=linea_de_color.id
          puts "===============color id:"+@linea_de_color_id.to_s+"==============="
        end
      end

      formato_op = FormatoOp.new( referencia_de_orden: spreadsheet.row(i)[0],
      user_id:@usuario_id, montaje_id: @montaje_id, pieza_a_decorar_id: @pieza_a_decorar_id, maquina_id: @maquina_id, linea_de_color_id: @linea_de_color_id, linea_producto_id:@linea_produccion_id )

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

end
