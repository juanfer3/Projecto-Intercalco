class MaterialesController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /materiales
  # GET /materiales.json
  def index
    @materiales = Material.all.paginate(page: params[:page], per_page: 20).order('codigo')
  end

  def import_materiales_excel
    #code
    file = params[:file]
    begin
      errores_o_true = Material.subir_excel(file)

      respond_to do |format|
        if errores_o_true == true
          format.html { redirect_to materiales_path, notice: 'Materiales Importados' }
          format.json { render :show, status: :created, location: @material }
          format.js
        else
          @errores = errores_o_true
          format.html { render materiales_path}
          format.js
        end
    end
    rescue Exception => e
      flash[:notice] = "Tipo de archivo no valido"
      redirect_to materiales_path
    end
  end

  # GET /materiales/1
  # GET /materiales/1.json
  def show

    respond_to do |format|
        format.html
        format.js
    end

  end

  # GET /materiales/new
  def new
    @material = Material.new
    ultimo_material = Material.all
    cont = 0
    @last_codigo = nil
    if ultimo_material.any?
      ultimo_material.each do |material|
          if material.codigo.length > 0
            codigo = material.codigo.to_i if material.codigo.match(/^\d+$/)
              if cont < codigo
                cont = codigo
                @last_codigo = material.codigo
              end
          end
      end
    end
  end

  # GET /materiales/1/edit
  def edit
  end

  # POST /materiales
  # POST /materiales.json
  def create
    @material = Material.new(material_params)

    respond_to do |format|
      if @material.save
        format.html { redirect_to materiales_url, notice: 'Registro creado.' }
        format.json { render :show, status: :created, location: @material }
      else
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materiales/1
  # PATCH/PUT /materiales/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to materiales_url, notice: 'Registro creado.' }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materiales/1
  # DELETE /materiales/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to materiales_url, notice: 'Registro eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:codigo, :descripcion, :tipo_de_unidad,:medida_material, :cantidad, :estado)
    end
end
