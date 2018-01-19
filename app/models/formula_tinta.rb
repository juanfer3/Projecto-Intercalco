class FormulaTinta < ApplicationRecord
  belongs_to :tinta_formulada
  belongs_to :tinta


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

      @tinta_cod= spreadsheet.row(i)[3]
      puts "****************************************"+@tinta_cod.to_s+"==========="
      @tinta = Tinta.find_by(codigo: @tinta_cod)


      
      puts "**************************************** Busqueda: "+@tinta.codigo.to_s+"==========="

      codigoTF = spreadsheet.row(i)[0]
      puts "****************************************"+codigoTF.to_s+"==========="
      @TintaFormulada = TintaFormulada.find_by(codigo: codigoTF)
      puts "****************************************nombre de Busquedad: "+@TintaFormulada.codigo.to_s+"==========="





      tintaFormulada = FormulaTinta.new(tinta_formulada_id:@TintaFormulada.id, tinta_id: @tinta.id, porcentaje: spreadsheet.row(i)[5])

      unless tintaFormulada.save
        tintaFormulada.errors.full_messages.each do |message|
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
