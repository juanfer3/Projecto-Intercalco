class Montaje < ApplicationRecord
  belongs_to :cliente

  has_many :piezas , inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :piezas, reject_if: :all_blank, allow_destroy: true

  has_many :tintas_fop_tiro, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :tintas_fop_tiro, reject_if: :all_blank, allow_destroy: true

  has_many :tintas_fop_retiro, inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :tintas_fop_retiro, reject_if: :all_blank, allow_destroy: true

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


              formato_op = Montaje.new( codigo:spreadsheet.row(i)[1], nombre: spreadsheet.row(i)[2], cliente_id: @cliente_id)

              if formato_op.save
                puts "**************Montaje Guardado**************************"

                    @mo = Montaje.find_by(nombre: @montaje_nombre)



                    Pieza.new( codigo:spreadsheet.row(i)[3], nombre: spreadsheet.row(i)[4], montaje_id: @mo.id)

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
