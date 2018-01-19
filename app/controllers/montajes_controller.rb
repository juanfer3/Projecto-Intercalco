class MontajesController < ApplicationController
  before_action :set_montaje, only: [:show, :edit, :update, :destroy]

  # GET /montajes
  # GET /montajes.json
  def index
    @montajes = Montaje.all
  end

  def import__MP_from_excel
    file = params[:file]
    begin
      errores_o_true = Montaje.subir_MP_from_excel(file)

      respond_to do |format|
        if errores_o_true == true
          format.html { redirect_to montajes_path, notice: 'Montajes y Piezas Importados Importados' }
          format.json { render :show, status: :created, location: @cliente }
        else
          @errores = errores_o_true
          format.html { render 'vista_subir_excel'}
        end
    end
    rescue Exception => e
      flash[:notice] = "Tipo de archivo no valido"
      redirect_to montajes_path
    end
  end

  def import_montaje_from_excel

    file = params[:file]
    begin
      errores_o_true = Montaje.subir_montaje_from_excel(file)

      respond_to do |format|
        if errores_o_true == true
          format.html { redirect_to montajes_path, notice: 'Montajes Importados' }
          format.json { render :show, status: :created, location: @cliente }
        else
          @errores = errores_o_true
          format.html { render 'vista_subir_excel'}
        end
    end
    rescue Exception => e
      flash[:notice] = "Tipo de archivo no valido"
      redirect_to montajes_path
    end
  end

  # GET /montajes/1
  # GET /montajes/1.json
  def show
  end

  # GET /montajes/new
  def new
    @montaje = Montaje.new
    @montaje.piezas.build
    @montaje.tintas_fop_tiro.build
    @montaje.tintas_fop_retiro.build
  end

  # GET /montajes/1/edit
  def edit
  end

  # POST /montajes
  # POST /montajes.json
  def create
    @montaje = Montaje.new(montaje_params)

    respond_to do |format|
      if @montaje.save
        format.html { redirect_to @montaje, notice: 'Montaje was successfully created.' }
        format.json { render :show, status: :created, location: @montaje }
      else
        format.html { render :new }
        format.json { render json: @montaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /montajes/1
  # PATCH/PUT /montajes/1.json
  def update
    respond_to do |format|
      if @montaje.update(montaje_params)
        format.html { redirect_to @montaje, notice: 'Montaje was successfully updated.' }
        format.json { render :show, status: :ok, location: @montaje }
      else
        format.html { render :edit }
        format.json { render json: @montaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /montajes/1
  # DELETE /montajes/1.json
  def destroy
    @montaje.destroy
    respond_to do |format|
      format.html { redirect_to montajes_url, notice: 'Informacion de Montaje Destruida.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_montaje
      @montaje = Montaje.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def montaje_params
      params.require(:montaje).permit(:cliente_id, :nombre, :tamano, :dimension,
        :dimension_1, :dimension_2, :codigo, :numero_de_montaje, :tipo_de_unidad,
         :cantidad_total, :observacion, :modo_de_empaque, :fecha_de_creacion,:estado,:_destroy,
        piezas_attributes:[:montaje_id, :nombre, :tamano, :tipo_de_unidad, :dimension, :descripcion, :cantidad, :codigo ,:estado, :_destroy],
      tintas_fop_retiro_attributes:[:formato_op_id, :malla_id, :tipo_de_tinta, :color, :estado],
      tintas_fop_tiro_attributes:[:formato_op_id, :malla_id, :tipo_de_tinta, :color, :estado])
    end
end
