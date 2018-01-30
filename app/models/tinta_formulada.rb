class TintaFormulada < ApplicationRecord
  belongs_to :linea_de_color
  belongs_to :malla

  has_many :formulas_tinta, inverse_of: :tinta_formulada, dependent: :destroy
  accepts_nested_attributes_for :formulas_tinta, reject_if: :all_blank, allow_destroy: true


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

      @nombre_malla = spreadsheet.row(i)[4]
      puts "****************************************"+@nombre_malla.to_s+"==========="
      @Malla = Malla.find_by(nombre: @nombre_malla)

      nombre_lc = spreadsheet.row(i)[1]
      puts "****************************************"+nombre_lc+"==========="
      @lineaC = LineaDeColor.find_by(nombre: nombre_lc)
      puts "****************************************nombre de Busquedad: "+@lineaC.nombre.to_s+"==========="


      puts "****************************************nombre de Busquedad: "+@Malla.nombre.to_s+"==========="


      tintaFormulada = TintaFormulada.new(linea_de_color_id:@lineaC.id , codigo: spreadsheet.row(i)[0], descripcion: spreadsheet.row(i)[2],pantone:spreadsheet.row(i)[3], malla_id: @Malla.id)

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
