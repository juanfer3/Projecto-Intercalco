class Tinta < ApplicationRecord
  belongs_to :malla
  belongs_to :linea_de_color


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


      @nombre_lc = spreadsheet.row(i)[1]
      @lineaC = LineaDeColor.find_by(nombre: @nombre_lc)




      tinta = Tinta.new(linea_de_color_id:@lineaC.id , codigo: spreadsheet.row(i)[0], descripcion: spreadsheet.row(i)[2])

      unless tinta.save
        tinta.errors.full_messages.each do |message|
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
