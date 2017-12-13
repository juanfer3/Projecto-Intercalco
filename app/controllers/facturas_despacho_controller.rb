class FacturasDespachoController < ApplicationController
  before_action :set_factura_despacho, only: [:show, :edit, :update, :destroy]

  # GET /facturas_despacho
  # GET /facturas_despacho.json
  def index
    @facturas_despacho = FacturaDespacho.all
  end

  # GET /facturas_despacho/1
  # GET /facturas_despacho/1.json
  def show
  end

  # GET /facturas_despacho/new
  def new
    @factura_despacho = FacturaDespacho.new
    @factura_despacho.remisiones.build
    @remision=Remision.new
  end

  # GET /facturas_despacho/1/edit
  def edit
  end

  # POST /facturas_despacho
  # POST /facturas_despacho.json
  def create
    @factura_despacho = FacturaDespacho.new(factura_despacho_params)

    respond_to do |format|
      if @factura_despacho.save
        format.html {redirect_to tiempos_de_entrega_url}
        format.js{}
      else
        format.html { render :new }
        format.json { render json: @factura_despacho.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facturas_despacho/1
  # PATCH/PUT /facturas_despacho/1.json
  def update
    respond_to do |format|
      if @factura_despacho.update(factura_despacho_params)
        format.html {redirect_to tiempos_de_entrega_url}
        format.js{}
      else
        format.html { render :edit }
        format.json { render json: @factura_despacho.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facturas_despacho/1
  # DELETE /facturas_despacho/1.json
  def destroy
    @factura_despacho.destroy
    respond_to do |format|
      format.html {redirect_to tiempos_de_entrega_url}
      format.js{}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_factura_despacho
      @factura_despacho = FacturaDespacho.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def factura_despacho_params
      params.require(:factura_despacho).permit(:tiempos_de_entrega_id, :numero_de_factura, :total_facturado, :iva, :descuento, :cancelada, :cantidad_faltante, :total_enviado, :estado,
      remisiones_attributes:[:factura_despacho_id, :numero_de_remision, :fecha_de_despacho, :cantidad_enviada, :precio_a_facturar, :cantidad_faltante, :entrega_cumplida, :estado])
    end
end
