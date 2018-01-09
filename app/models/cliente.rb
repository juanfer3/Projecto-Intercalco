class Cliente < ApplicationRecord

  belongs_to :user
  has_many :contactos , inverse_of: :cliente, dependent: :destroy
  accepts_nested_attributes_for :contactos, reject_if: :all_blank, allow_destroy: true




  def self.subir_excel(file ,my_user_id)

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

      cliente = Cliente.new(nombre: spreadsheet.row(i)[0], nit: spreadsheet.row(i)[1],direccion:spreadsheet.row(i)[2],telefono:spreadsheet.row(i)[3],user_id:my_user_id)

      unless cliente.save
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

#Contactos Excel

  def self.subir_excel_contactos(file ,my_user_id,id_cliente)

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

      contacto = Contacto.new(nombre_contacto: spreadsheet.row(i)[0], telefono: spreadsheet.row(i)[1],celular:spreadsheet.row(i)[2],correo:spreadsheet.row(i)[3],user_id:my_user_id, cliente_id:id_cliente)

      unless contacto.save
        contacto.errors.full_messages.each do |message|
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
