class ProduccionesOrdenesController < ApplicationController
  before_action :set_produccion_orden, only: [:show, :edit, :update, :destroy]

  # GET /producciones_ordenes
  # GET /producciones_ordenes.json
  def index
    @producciones_ordenes = ProduccionOrden.all
  end

  # GET /producciones_ordenes/1
  # GET /producciones_ordenes/1.json
  def show
  end

  # GET /producciones_ordenes/new
  def new
    @produccion_orden = ProduccionOrden.new
  end

  # GET /producciones_ordenes/1/edit
  def edit
  end

  # POST /producciones_ordenes
  # POST /producciones_ordenes.json
  def create
    @produccion_orden = ProduccionOrden.new(produccion_orden_params)

    respond_to do |format|
      if @produccion_orden.save
        format.html { redirect_to @produccion_orden, notice: 'Produccion orden was successfully created.' }
        format.json { render :show, status: :created, location: @produccion_orden }
      else
        format.html { render :new }
        format.json { render json: @produccion_orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /producciones_ordenes/1
  # PATCH/PUT /producciones_ordenes/1.json
  def update
    respond_to do |format|
      if @produccion_orden.update(produccion_orden_params)
        format.html { redirect_to @produccion_orden, notice: 'Produccion orden was successfully updated.' }
        format.json { render :show, status: :ok, location: @produccion_orden }
      else
        format.html { render :edit }
        format.json { render json: @produccion_orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /producciones_ordenes/1
  # DELETE /producciones_ordenes/1.json
  def destroy
    @produccion_orden.destroy
    respond_to do |format|
      format.html { redirect_to producciones_ordenes_url, notice: 'Produccion orden was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produccion_orden
      @produccion_orden = ProduccionOrden.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produccion_orden_params
      params.require(:produccion_orden).permit(:cliente_id, :user_id, :maquina_id, :montaje_id, :pieza_a_decorar_id, :numero_de_orden, :mes, :cantidad_programada, :precio_unitario, :valor_total, :tipo_de_produccion, :tamanos_total, :cavidad, :tipo_de_linea, :fecha, :fecha_compromiso, :cantidad_hoja, :tiro, :retiro, :observacion, :pantalla, :color, :corte_material, :impresion, :troquel, :acabado, :habilitar_impresion, :habilitar_acabado, :estado_de_orde, :estado)
    end
end
