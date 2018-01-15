class PiezasADecorarController < ApplicationController
  before_action :set_pieza_a_decorar, only: [:show, :edit, :update, :destroy]

  # GET /piezas_a_decorar
  # GET /piezas_a_decorar.json
  def index
    @piezas_a_decorar = PiezaADecorar.all
  end

  # GET /piezas_a_decorar/1
  # GET /piezas_a_decorar/1.json
  def show
  end

  # GET /piezas_a_decorar/new
  def new
    @pieza_a_decorar = PiezaADecorar.new
  end

  # GET /piezas_a_decorar/1/edit
  def edit
  end

  # POST /piezas_a_decorar
  # POST /piezas_a_decorar.json
  def create
    @pieza_a_decorar = PiezaADecorar.new(pieza_a_decorar_params)

    respond_to do |format|
      if @pieza_a_decorar.save
        format.html { redirect_to @pieza_a_decorar, notice: 'Pieza a decorar was successfully created.' }
        format.json { render :show, status: :created, location: @pieza_a_decorar }
      else
        format.html { render :new }
        format.json { render json: @pieza_a_decorar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /piezas_a_decorar/1
  # PATCH/PUT /piezas_a_decorar/1.json
  def update
    respond_to do |format|
      if @pieza_a_decorar.update(pieza_a_decorar_params)
        format.html { redirect_to @pieza_a_decorar, notice: 'Pieza a decorar was successfully updated.' }
        format.json { render :show, status: :ok, location: @pieza_a_decorar }
      else
        format.html { render :edit }
        format.json { render json: @pieza_a_decorar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /piezas_a_decorar/1
  # DELETE /piezas_a_decorar/1.json
  def destroy
    @pieza_a_decorar.destroy
    respond_to do |format|
      format.html { redirect_to piezas_a_decorar_url, notice: 'Pieza a decorar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pieza_a_decorar
      @pieza_a_decorar = PiezaADecorar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pieza_a_decorar_params
      params.require(:pieza_a_decorar).permit(:nombre, :descripccion, :estado)
    end
end
