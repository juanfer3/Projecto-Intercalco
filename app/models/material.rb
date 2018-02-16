class Material < ApplicationRecord
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

    columnas_validas=["CODIGO","DESCRIPCION"]

    row = Hash[[header, spreadsheet.row(2)].transpose]

    columnas_archivos = row.keys

    columnas_archivos = columnas_archivos.map(&:to_s)

    columnas_archivos = columnas_archivos.map(&:upcase)


    raise "El orden de las columnas no es válido"  unless  columnas_validas == columnas_archivos
    



    (2..spreadsheet.last_row).each do |i|
      codigo = spreadsheet.row(i)[0].to_s.upcase
      descripcion= spreadsheet.row(i)[1].to_s.upcase

      if descripcion.length <= 0
      else

        @bus_material = Material.find_by(descripcion: descripcion)

        if @bus_material == nil
          material = Material.new(codigo: codigo, descripcion: descripcion)
          unless material.save
            material.errors.full_messages.each do |message|
              @errores << "Error en la fila #{i}, columna #{message}"
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
