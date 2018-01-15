class PiezasController < ApplicationController
  before_action :set_pieza, only: [:show, :edit, :update, :destroy]

  # GET /piezas
  # GET /piezas.json
  def index
    @piezas = Pieza.all
  end

  # GET /piezas/1
  # GET /piezas/1.json
  def show
  end

  # GET /piezas/new
  def new
    @pieza = Pieza.new
  end

  # GET /piezas/1/edit
  def edit
  end

  # POST /piezas
  # POST /piezas.json
  def create
    @pieza = Pieza.new(pieza_params)

    respond_to do |format|
      if @pieza.save
        format.html { redirect_to @pieza, notice: 'Pieza was successfully created.' }
        format.json { render :show, status: :created, location: @pieza }
      else
        format.html { render :new }
        format.json { render json: @pieza.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /piezas/1
  # PATCH/PUT /piezas/1.json
  def update
    respond_to do |format|
      if @pieza.update(pieza_params)
        format.html { redirect_to @pieza, notice: 'Pieza was successfully updated.' }
        format.json { render :show, status: :ok, location: @pieza }
      else
        format.html { render :edit }
        format.json { render json: @pieza.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /piezas/1
  # DELETE /piezas/1.json
  def destroy
    @pieza.destroy
    respond_to do |format|
      format.html { redirect_to piezas_url, notice: 'Pieza was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pieza
      @pieza = Pieza.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pieza_params
      params.require(:pieza).permit(:montaje_id, :nombre, :tamano, :tipo_de_unidad, :dimension, :descripcion, :cantidad, :codigo, :estado)
    end
end
