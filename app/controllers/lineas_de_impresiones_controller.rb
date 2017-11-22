class LineasDeImpresionesController < ApplicationController
  before_action :set_linea_de_impresion, only: [:show, :edit, :update, :destroy]

  # GET /lineas_de_impresiones
  # GET /lineas_de_impresiones.json
  def index
    @lineas_de_impresiones = LineaDeImpresion.all
  end

  # GET /lineas_de_impresiones/1
  # GET /lineas_de_impresiones/1.json
  def show
  end

  # GET /lineas_de_impresiones/new
  def new
    @linea_de_impresion = LineaDeImpresion.new
  end

  # GET /lineas_de_impresiones/1/edit
  def edit
  end

  # POST /lineas_de_impresiones
  # POST /lineas_de_impresiones.json
  def create
    @linea_de_impresion = LineaDeImpresion.new(linea_de_impresion_params)

    respond_to do |format|
      if @linea_de_impresion.save
        format.html { redirect_to @linea_de_impresion, notice: 'Linea de impresion was successfully created.' }
        format.json { render :show, status: :created, location: @linea_de_impresion }
      else
        format.html { render :new }
        format.json { render json: @linea_de_impresion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lineas_de_impresiones/1
  # PATCH/PUT /lineas_de_impresiones/1.json
  def update
    respond_to do |format|
      if @linea_de_impresion.update(linea_de_impresion_params)
        format.html { redirect_to @linea_de_impresion, notice: 'Linea de impresion was successfully updated.' }
        format.json { render :show, status: :ok, location: @linea_de_impresion }
      else
        format.html { render :edit }
        format.json { render json: @linea_de_impresion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lineas_de_impresiones/1
  # DELETE /lineas_de_impresiones/1.json
  def destroy
    @linea_de_impresion.destroy
    respond_to do |format|
      format.html { redirect_to lineas_de_impresiones_url, notice: 'Linea de impresion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linea_de_impresion
      @linea_de_impresion = LineaDeImpresion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def linea_de_impresion_params
      params.require(:linea_de_impresion).permit(:tipo_de_linea, :descripcion, :estado)
    end
end
