class AcabadosController < ApplicationController
  before_action :set_acabado, only: [:show, :edit, :update, :destroy]

  # GET /acabados
  # GET /acabados.json
  def index
    @acabados = Acabado.all
  end
  

  # GET /acabados/1
  # GET /acabados/1.json
  def show
  end

  # GET /acabados/new
  def new
    @acabado = Acabado.new
  end

  # GET /acabados/1/edit
  def edit
  end

  # POST /acabados
  # POST /acabados.json
  def create
    @acabado = Acabado.new(acabado_params)

    respond_to do |format|
      if @acabado.save
        format.html { redirect_to acabados_path, notice: 'Acabado registrado.' }
        format.json { render :show, status: :created, location: @acabado }
      else
        format.html { render :new }
        format.json { render json: @acabado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acabados/1
  # PATCH/PUT /acabados/1.json
  def update
    respond_to do |format|
      if @acabado.update(acabado_params)
        format.html { redirect_to acabados_url, notice: 'Acabado editado.' }
        format.json { render :show, status: :ok, location: @acabado }
      else
        format.html { render :edit }
        format.json { render json: @acabado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acabados/1
  # DELETE /acabados/1.json
  def destroy
    @acabado.destroy
    respond_to do |format|
      format.html { redirect_to acabados_url, notice: 'Acabado elimniado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acabado
      @acabado = Acabado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acabado_params
      params.require(:acabado).permit(:nombre, :descripcion)
    end
end
