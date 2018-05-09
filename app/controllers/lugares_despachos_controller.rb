class LugaresDespachosController < ApplicationController
  before_action :set_lugar_despacho, only: [:show, :edit, :update, :destroy]

  # GET /lugares_despachos
  # GET /lugares_despachos.json
  def index
    @lugares_despachos = LugarDespacho.all
  end

  # GET /lugares_despachos/1
  # GET /lugares_despachos/1.json
  def show
  end

  # GET /lugares_despachos/new
  def new
    @lugar_despacho = LugarDespacho.new
  end

  # GET /lugares_despachos/1/edit
  def edit
  end

  # POST /lugares_despachos
  # POST /lugares_despachos.json
  def create
    @lugar_despacho = LugarDespacho.new(lugar_despacho_params)

    respond_to do |format|
      if @lugar_despacho.save
        format.html { redirect_to @lugar_despacho, notice: 'Lugar despacho was successfully created.' }
        format.json { render :show, status: :created, location: @lugar_despacho }
      else
        format.html { render :new }
        format.json { render json: @lugar_despacho.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lugares_despachos/1
  # PATCH/PUT /lugares_despachos/1.json
  def update
    respond_to do |format|
      if @lugar_despacho.update(lugar_despacho_params)
        format.html { redirect_to @lugar_despacho, notice: 'Lugar despacho was successfully updated.' }
        format.json { render :show, status: :ok, location: @lugar_despacho }
      else
        format.html { render :edit }
        format.json { render json: @lugar_despacho.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lugares_despachos/1
  # DELETE /lugares_despachos/1.json
  def destroy
    @lugar_despacho.destroy
    respond_to do |format|
      format.html { redirect_to lugares_despachos_url, notice: 'Lugar despacho was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lugar_despacho
      @lugar_despacho = LugarDespacho.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lugar_despacho_params
      params.require(:lugar_despacho).permit(:cliente_id, :nombre, :direccion, :telefono)
    end
end
