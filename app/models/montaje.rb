class Montaje < ApplicationRecord
  belongs_to :cliente

  has_many :piezas , inverse_of: :montaje, dependent: :destroy
  accepts_nested_attributes_for :piezas, reject_if: :all_blank, allow_destroy: true


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

end
