class ContenedoresDeAcabadosController < ApplicationController
  before_action :set_contenedor_de_acabados, only: [:show, :edit, :update, :destroy]

  # GET /contenedores_de_acabados
  # GET /contenedores_de_acabados.json
  def index
    @contenedores_de_acabados = ContenedorDeAcabados.all
  end

  # GET /contenedores_de_acabados/1
  # GET /contenedores_de_acabados/1.json
  def show
  end

  # GET /contenedores_de_acabados/new
  def new
    @contenedor_de_acabados = ContenedorDeAcabados.new
  end

  # GET /contenedores_de_acabados/1/edit
  def edit
  end

  # POST /contenedores_de_acabados
  # POST /contenedores_de_acabados.json
  def create
    @contenedor_de_acabados = ContenedorDeAcabados.new(contenedor_de_acabados_params)

    respond_to do |format|
      if @contenedor_de_acabados.save
        format.html { redirect_to @contenedor_de_acabados, notice: 'Contenedor de acabados was successfully created.' }
        format.json { render :show, status: :created, location: @contenedor_de_acabados }
      else
        format.html { render :new }
        format.json { render json: @contenedor_de_acabados.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contenedores_de_acabados/1
  # PATCH/PUT /contenedores_de_acabados/1.json
  def update
    respond_to do |format|
      if @contenedor_de_acabados.update(contenedor_de_acabados_params)
        format.html { redirect_to @contenedor_de_acabados, notice: 'Contenedor de acabados was successfully updated.' }
        format.json { render :show, status: :ok, location: @contenedor_de_acabados }
      else
        format.html { render :edit }
        format.json { render json: @contenedor_de_acabados.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contenedores_de_acabados/1
  # DELETE /contenedores_de_acabados/1.json
  def destroy
    @contenedor_de_acabados.destroy
    respond_to do |format|
      format.html { redirect_to contenedores_de_acabados_url, notice: 'Contenedor de acabados was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contenedor_de_acabados
      @contenedor_de_acabados = ContenedorDeAcabados.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contenedor_de_acabados_params
      params.require(:contenedor_de_acabados).permit(:montaje_id, :acabado_id)
    end
end
