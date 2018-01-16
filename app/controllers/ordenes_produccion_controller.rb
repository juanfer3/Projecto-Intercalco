class OrdenesProduccionController < ApplicationController
  before_action :set_orden_produccion, only: [:show, :edit, :update, :destroy]

  # GET /ordenes_produccion
  # GET /ordenes_produccion.json
  def index
    @ordenes_produccion = OrdenProduccion.all
  end

  def buscar_fop
    @formatos_op = FormatoOp.joins(:cliente,:montaje).find(params[:id])
    render json: @formatos_op .to_json(:include => :cliente)
  end

  # GET /ordenes_produccion/1
  # GET /ordenes_produccion/1.json
  def show
  end

  # GET /ordenes_produccion/new
  def new
    @orden_produccion = OrdenProduccion.new
  end

  # GET /ordenes_produccion/1/edit
  def edit
  end

  # POST /ordenes_produccion
  # POST /ordenes_produccion.json
  def create
    @orden_produccion = OrdenProduccion.new(orden_produccion_params)

    respond_to do |format|
      if @orden_produccion.save
        format.html { redirect_to @orden_produccion, notice: 'Orden produccion was successfully created.' }
        format.json { render :show, status: :created, location: @orden_produccion }
      else
        format.html { render :new }
        format.json { render json: @orden_produccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordenes_produccion/1
  # PATCH/PUT /ordenes_produccion/1.json
  def update
    respond_to do |format|
      if @orden_produccion.update(orden_produccion_params)
        format.html { redirect_to @orden_produccion, notice: 'Orden produccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @orden_produccion }
      else
        format.html { render :edit }
        format.json { render json: @orden_produccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordenes_produccion/1
  # DELETE /ordenes_produccion/1.json
  def destroy
    @orden_produccion.destroy
    respond_to do |format|
      format.html { redirect_to ordenes_produccion_url, notice: 'Orden produccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden_produccion
      @orden_produccion = OrdenProduccion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_produccion_params
      params.require(:orden_produccion).permit(:formato_op_id, :numero_de_orden, :mes_id, :cantidad_programada, :precio_unitario, :valor_total, :tipo_de_produccion, :material, :temperatura, :tamanos_total, :cavidad, :fecha, :fecha_compromiso, :cantidad_hoja, :porcentaje_macula, :tiro, :retiro, :observacion, :pantalla, :color, :corte_material, :impresion, :troquel, :acabado, :habilitar_impresion, :habilitar_acabado, :estado_de_orden, :estado)
    end
end
