class FacturasController < ApplicationController
  before_action :set_factura, only: [:show, :edit, :update, :destroy]

  # GET /facturas
  # GET /facturas.json
  def index
    @facturas = Factura.all
      @ordenes_produccion = OrdenProduccion.all.paginate(page: params[:page], per_page: 20).order('numero_de_orden').distinct
  end

  def desarrollar_factura
    @orden_produccion = OrdenProduccion.find(params[:id])

    @orden_produccion.compromisos_de_entrega.each do |compromisos|
                @remisiones = compromisos
                puts "*******************Remision#{@remisiones}*********************"
    end

    @factura = Factura.new
    @factura.contenedor_de_remisiones.build
    respond_to do |format|
      format.js
    end
  end

  def info_factura
    @orden_produccion = OrdenProduccion.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # GET /facturas/1
  # GET /facturas/1.json
  def show
    @orden_produccion = OrdenProduccion.find_by(id:@factura.orden_produccion.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /facturas/new
  def new
    @factura = Factura.new
    @factura.contenedor_de_remisiones.build
  end

  # GET /facturas/1/edit
  def edit
  end

  # POST /facturas
  # POST /facturas.json
  def create
    @factura = Factura.new(factura_params)

    respond_to do |format|
      if @factura.save
        format.html { redirect_to @factura, notice: 'Factura was successfully created.' }
        format.json { render :show, status: :created, location: @factura }
      else
        format.html { render :new }
        format.json { render json: @factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facturas/1
  # PATCH/PUT /facturas/1.json
  def update
    respond_to do |format|
      if @factura.update(factura_params)
        format.html { redirect_to @factura, notice: 'Factura was successfully updated.' }
        format.json { render :show, status: :ok, location: @factura }
      else
        format.html { render :edit }
        format.json { render json: @factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facturas/1
  # DELETE /facturas/1.json
  def destroy
    @factura.destroy
    respond_to do |format|
      format.html { redirect_to facturas_url, notice: 'Factura was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_factura
      @factura = Factura.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def factura_params
      params.require(:factura).permit(:orden_produccion_id, :numero_de_factura, :iva,
        :descuento, :total_facturado, :cancelada, :compromiso_de_entrega_ids=>[],
       contenedor_de_remisiones_attributes: [:factura_id,:id,  :_destroy, :compromiso_de_entrega_ids => []] )
    end
end
