class DespachosController < ApplicationController
  before_action :set_despacho, only: [:show, :edit, :update, :destroy]

  # GET /despachos
  # GET /despachos.json
  def index
    @despachos = Despacho.all
  end

  # GET /despachos/1
  # GET /despachos/1.json
  def show
  end

  # GET /despachos/new
  def new
    @despacho = Despacho.new
  end

  # GET /despachos/1/edit
  def edit
  end

  # POST /despachos
  # POST /despachos.json
  def create
    @despacho = Despacho.new(despacho_params)

    respond_to do |format|
      if @despacho.save
        format.html { redirect_to @despacho, notice: 'Despacho was successfully created.' }
        format.json { render :show, status: :created, location: @despacho }
      else
        format.html { render :new }
        format.json { render json: @despacho.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /despachos/1
  # PATCH/PUT /despachos/1.json
  def update
    respond_to do |format|
      if @despacho.update(despacho_params)
        format.html { redirect_to @despacho, notice: 'Despacho was successfully updated.' }
        format.json { render :show, status: :ok, location: @despacho }
      else
        format.html { render :edit }
        format.json { render json: @despacho.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /despachos/1
  # DELETE /despachos/1.json
  def destroy
    @despacho.destroy
    respond_to do |format|
      format.html { redirect_to despachos_url, notice: 'Despacho was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_despacho
      @despacho = Despacho.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def despacho_params
      params.require(:despacho).permit(:pedido_id, :nombre, :nit, :telefono, :lugar_de_despacho, :direccion, :celular, :correo, :recibe, :observacion, :facturar, :entregar_factura, :estado)
    end
end
