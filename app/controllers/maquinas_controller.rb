class MaquinasController < ApplicationController
  before_action :set_maquina, only: [:show, :edit, :update, :destroy]
  require 'colorize'
  # GET /maquinas
  # GET /maquinas.json
  def index
    @maquinas = Maquina.all.order("nombre")
  end

  def consulta_por_maquinas
    #code

    puts "==============CONSULTA DE MAQUINAS===================="
    @maquina = Maquina.find(params[:id])
    @ordenes_produccion = OrdenProduccion.joins(:montaje =>[:cliente,:contenedores_de_maquinas]).where("contenedores_de_maquinas.maquina_id= ?", @maquina.id)
    respond_to do |format|
      format.js
    end
  end

  def produccion_por_maquinas
    #code

    estado = true
    @maquinas = Maquina.where("estado = ?", estado).order("nombre")
    @ordenes_produccion = OrdenProduccion.all.paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
    end
  end

  # GET /maquinas/1
  # GET /maquinas/1.json
  def show
  end

  # GET /maquinas/new
  def new
    @maquina = Maquina.new
  end

  # GET /maquinas/1/edit
  def edit
  end

  # POST /maquinas
  # POST /maquinas.json
  def create
    @maquina = Maquina.new(maquina_params)

    respond_to do |format|
      if @maquina.save
        format.html { redirect_to maquinas_url, notice: 'Registro creado.' }
        format.json { render :show, status: :created, location: @maquina }
      else
        format.html { render :new }
        format.json { render json: @maquina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maquinas/1
  # PATCH/PUT /maquinas/1.json
  def update
    respond_to do |format|
      if @maquina.update(maquina_params)
        format.html { redirect_to maquinas_url, notice: 'Registro editado.' }
        format.json { render :show, status: :ok, location: @maquina }
      else
        format.html { render :edit }
        format.json { render json: @maquina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maquinas/1
  # DELETE /maquinas/1.json
  def destroy
    @maquina.destroy
    respond_to do |format|
      format.html { redirect_to maquinas_url, notice: 'Registro eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maquina
      @maquina = Maquina.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maquina_params
      params.require(:maquina).permit(:nombre, :descripcion, :formato_de_tamaño,:estado)
    end
end
