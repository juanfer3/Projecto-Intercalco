class Tinta < ApplicationRecord
  belongs_to :linea_de_color

  has_many :tintas_formuladas, inverse_of: :tinta, dependent: :destroy
  accepts_nested_attributes_for :tintas_formuladas, reject_if: :all_blank, allow_destroy: true

  def self.buscar_tinta(data)
    #code
    puts "****************Entrada************************"
    dato=data.to_s.upcase
    @inks = Tinta.where('tintas.descripcion LIKE ?', '%'+dato+'%').distinct
    if @inks.any?
      puts "***************Existe*************************"
      return @inks
    else
      puts "***************No Existe*************************"
      return @inks
    end
  end


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


      nombre_lc = spreadsheet.row(i)[1]
      puts "****************************************"+nombre_lc+"==========="
      @lineaC = LineaDeColor.find_by(nombre: nombre_lc)
      puts "****************************************nombre de Busquedad: "+@lineaC.nombre.to_s+"==========="



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
