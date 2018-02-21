class Cliente < ApplicationRecord

  belongs_to :user
  has_many :contactos , inverse_of: :cliente, dependent: :destroy
  accepts_nested_attributes_for :contactos, reject_if: :all_blank, allow_destroy: true

  has_many :montajes , inverse_of: :cliente, dependent: :destroy
  accepts_nested_attributes_for :montajes, reject_if: :all_blank, allow_destroy: true



  def self.subir_excel(file )

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


      cliente_nombre = spreadsheet.row(i)[0].to_s.upcase

      if cliente_nombre.length <= 0
          puts "******************Array Vacio**********************"
      else
        puts "****************Busqueda del cliente************************"
        buscar_cliente = Cliente.find_by(nombre: cliente_nombre)
        if buscar_cliente == nil
          puts "***************El cliente no existe*************************"
          nit = spreadsheet.row(i)[1]
          direccion = spreadsheet.row(i)[2].to_s.upcase
          telefono = spreadsheet.row(i)[3]
          comercial = spreadsheet.row(i)[4].to_s.upcase

          puts "****************buscar user************************"
          user = User.find_by(nombre: comercial)
            puts "****************almacenamiento user************************"
          if user != nil
            puts "*****************el Usuario si existe***********************"
            cliente = Cliente.new(nombre: cliente_nombre, nit: nit,direccion: direccion,telefono: telefono,user_id:user.id)
            unless cliente.save
              cliente.errors.full_messages.each do |message|
                @errores << "Error en la fila #{i}, columna #{message}"
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
