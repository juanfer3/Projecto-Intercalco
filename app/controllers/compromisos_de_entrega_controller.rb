class CompromisosDeEntregaController < ApplicationController
  before_action :set_compromiso_de_entrega, only: [:show, :edit, :update, :destroy]

  # GET /compromisos_de_entrega
  # GET /compromisos_de_entrega.json
  def index
    @compromisos_de_entrega = CompromisoDeEntrega.all
  end

  # GET /compromisos_de_entrega/1
  # GET /compromisos_de_entrega/1.json
  def show
  end

  # GET /compromisos_de_entrega/new
  def new
    @compromiso_de_entrega = CompromisoDeEntrega.new
  end

  # GET /compromisos_de_entrega/1/edit
  def edit
  end

  # POST /compromisos_de_entrega
  # POST /compromisos_de_entrega.json
  def create
    @compromiso_de_entrega = CompromisoDeEntrega.new(compromiso_de_entrega_params)

    respond_to do |format|
      if @compromiso_de_entrega.save
        format.html { redirect_to @compromiso_de_entrega, notice: 'Compromiso de entrega was successfully created.' }
        format.json { render :show, status: :created, location: @compromiso_de_entrega }
      else
        format.html { render :new }
        format.json { render json: @compromiso_de_entrega.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compromisos_de_entrega/1
  # PATCH/PUT /compromisos_de_entrega/1.json
  def update
    respond_to do |format|
      if @compromiso_de_entrega.update(compromiso_de_entrega_params)
        format.html { redirect_to @compromiso_de_entrega, notice: 'Compromiso de entrega was successfully updated.' }
        format.json { render :show, status: :ok, location: @compromiso_de_entrega }
      else
        format.html { render :edit }
        format.json { render json: @compromiso_de_entrega.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compromisos_de_entrega/1
  # DELETE /compromisos_de_entrega/1.json
  def destroy
    @compromiso_de_entrega.destroy
    respond_to do |format|
      format.html { redirect_to compromisos_de_entrega_url, notice: 'Compromiso de entrega was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compromiso_de_entrega
      @compromiso_de_entrega = CompromisoDeEntrega.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compromiso_de_entrega_params
      params.require(:compromiso_de_entrega).permit(:orden_produccion_id, :fecha_de_compromiso,
        :cantidad, :precio, :fecha_despacho, :cantidad_despacho, :precio_despacho,
        :diferencia, :numero_de_remision, :estado)
    end
end