class DetallesDeProduccionController < ApplicationController
  before_action :set_detalle_de_produccion, only: [:show, :edit, :update, :destroy]

  def editar
    @detalle_de_produccion.update(detalle_de_produccion_params)
  end

  # GET /detalles_de_produccion
  # GET /detalles_de_produccion.json
  def index
    @detalles_de_produccion = DetalleDeProduccion.all
  end

  # GET /detalles_de_produccion/1
  # GET /detalles_de_produccion/1.json
  def show
  end

  # GET /detalles_de_produccion/new
  def new
    @detalle_de_produccion = DetalleDeProduccion.new
  end

  # GET /detalles_de_produccion/1/edit
  def edit
  end

  # POST /detalles_de_produccion
  # POST /detalles_de_produccion.json
  def create
    @detalle_de_produccion = DetalleDeProduccion.new(detalle_de_produccion_params)

    respond_to do |format|
      if @detalle_de_produccion.save
        format.html { redirect_to @detalle_de_produccion, notice: 'Detalle de produccion was successfully created.' }
        format.json { render :show, status: :created, location: @detalle_de_produccion }
      else
        format.html { render :new }
        format.json { render json: @detalle_de_produccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detalles_de_produccion/1
  # PATCH/PUT /detalles_de_produccion/1.json
  def update
    respond_to do |format|
      if @detalle_de_produccion.update(detalle_de_produccion_params)
        format.html { redirect_to @detalle_de_produccion, notice: 'Detalle de produccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @detalle_de_produccion }
      else
        format.html { render :edit }
        format.json { render json: @detalle_de_produccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detalles_de_produccion/1
  # DELETE /detalles_de_produccion/1.json
  def destroy
    @detalle_de_produccion.destroy
    respond_to do |format|
      format.html { redirect_to detalles_de_produccion_url, notice: 'Detalle de produccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detalle_de_produccion
      @detalle_de_produccion = DetalleDeProduccion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def detalle_de_produccion_params
      params.require(:detalle_de_produccion).permit(:orden_de_produccion_id, :codigo, :descripcion, :cantidad, :fecha, :inventario, :estado)
    end
end
