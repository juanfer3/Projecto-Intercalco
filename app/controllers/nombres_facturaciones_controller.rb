class NombresFacturacionesController < ApplicationController
  before_action :set_nombre_facturacion, only: [:show, :edit, :update, :destroy]

  # GET /nombres_facturaciones
  # GET /nombres_facturaciones.json
  def index
    @nombres_facturaciones = NombreFacturacion.all
  end

  # GET /nombres_facturaciones/1
  # GET /nombres_facturaciones/1.json
  def show
  end

  # GET /nombres_facturaciones/new
  def new
    @nombre_facturacion = NombreFacturacion.new
  end

  # GET /nombres_facturaciones/1/edit
  def edit
  end

  # POST /nombres_facturaciones
  # POST /nombres_facturaciones.json
  def create
    @nombre_facturacion = NombreFacturacion.new(nombre_facturacion_params)

    respond_to do |format|
      if @nombre_facturacion.save
        format.html { redirect_to @nombre_facturacion, notice: 'Nombre facturacion was successfully created.' }
        format.json { render :show, status: :created, location: @nombre_facturacion }
      else
        format.html { render :new }
        format.json { render json: @nombre_facturacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nombres_facturaciones/1
  # PATCH/PUT /nombres_facturaciones/1.json
  def update
    respond_to do |format|
      if @nombre_facturacion.update(nombre_facturacion_params)
        format.html { redirect_to @nombre_facturacion, notice: 'Nombre facturacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @nombre_facturacion }
      else
        format.html { render :edit }
        format.json { render json: @nombre_facturacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nombres_facturaciones/1
  # DELETE /nombres_facturaciones/1.json
  def destroy
    @nombre_facturacion.destroy
    respond_to do |format|
      format.html { redirect_to nombres_facturaciones_url, notice: 'Nombre facturacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nombre_facturacion
      @nombre_facturacion = NombreFacturacion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nombre_facturacion_params
      params.require(:nombre_facturacion).permit(:cliente_id, :nombre, :direccion, :telefono)
    end
end
