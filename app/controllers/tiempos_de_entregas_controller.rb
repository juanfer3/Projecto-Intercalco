class TiemposDeEntregasController < ApplicationController
  before_action :set_tiempos_de_entrega, only: [:show, :edit, :update, :destroy]

  # GET /tiempos_de_entregas
  # GET /tiempos_de_entregas.json
  def index
    @tiempos_de_entregas = TiemposDeEntrega.all
  end

  # GET /tiempos_de_entregas/1
  # GET /tiempos_de_entregas/1.json
  def show
  end

  # GET /tiempos_de_entregas/new
  def new
    @tiempos_de_entrega = TiemposDeEntrega.new
  end

  # GET /tiempos_de_entregas/1/edit
  def edit
  end

  # POST /tiempos_de_entregas
  # POST /tiempos_de_entregas.json
  def create
    @tiempos_de_entrega = TiemposDeEntrega.new(tiempos_de_entrega_params)

    respond_to do |format|
      if @tiempos_de_entrega.save
        format.html { redirect_to @tiempos_de_entrega, notice: 'Tiempos de entrega was successfully created.' }
        format.json { render :show, status: :created, location: @tiempos_de_entrega }
      else
        format.html { render :new }
        format.json { render json: @tiempos_de_entrega.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tiempos_de_entregas/1
  # PATCH/PUT /tiempos_de_entregas/1.json
  def update
    respond_to do |format|
      if @tiempos_de_entrega.update(tiempos_de_entrega_params)
        format.html { redirect_to @tiempos_de_entrega, notice: 'Tiempos de entrega was successfully updated.' }
        format.json { render :show, status: :ok, location: @tiempos_de_entrega }
      else
        format.html { render :edit }
        format.json { render json: @tiempos_de_entrega.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiempos_de_entregas/1
  # DELETE /tiempos_de_entregas/1.json
  def destroy
    @tiempos_de_entrega.destroy
    respond_to do |format|
      format.html { redirect_to tiempos_de_entregas_url, notice: 'Tiempos de entrega was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tiempos_de_entrega
      @tiempos_de_entrega = TiemposDeEntrega.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tiempos_de_entrega_params
      params.require(:tiempos_de_entrega).permit(:pedido_id, :remision, :cantidad, :fecha_compromiso, :precio, :fecha_de_despacho, :cantidad_enviada, :precio_a_facturar, :cantidad_faltante, :anexo, :entrega_cumplida, :estado)
    end
end
