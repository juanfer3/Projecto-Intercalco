class ContenedoresDeMaquinasController < ApplicationController
  before_action :set_contenedor_de_maquinas, only: [:show, :edit, :update, :destroy]

  # GET /contenedores_de_maquinas
  # GET /contenedores_de_maquinas.json
  def index
    @contenedores_de_maquinas = ContenedorDeMaquinas.all
  end

  # GET /contenedores_de_maquinas/1
  # GET /contenedores_de_maquinas/1.json
  def show
  end

  # GET /contenedores_de_maquinas/new
  def new
    @contenedor_de_maquinas = ContenedorDeMaquinas.new
  end

  # GET /contenedores_de_maquinas/1/edit
  def edit
  end

  # POST /contenedores_de_maquinas
  # POST /contenedores_de_maquinas.json
  def create
    @contenedor_de_maquinas = ContenedorDeMaquinas.new(contenedor_de_maquinas_params)

    respond_to do |format|
      if @contenedor_de_maquinas.save
        format.html { redirect_to @contenedor_de_maquinas, notice: 'Contenedor de maquinas was successfully created.' }
        format.json { render :show, status: :created, location: @contenedor_de_maquinas }
      else
        format.html { render :new }
        format.json { render json: @contenedor_de_maquinas.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contenedores_de_maquinas/1
  # PATCH/PUT /contenedores_de_maquinas/1.json
  def update
    respond_to do |format|
      if @contenedor_de_maquinas.update(contenedor_de_maquinas_params)
        format.html { redirect_to @contenedor_de_maquinas, notice: 'Contenedor de maquinas was successfully updated.' }
        format.json { render :show, status: :ok, location: @contenedor_de_maquinas }
      else
        format.html { render :edit }
        format.json { render json: @contenedor_de_maquinas.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contenedores_de_maquinas/1
  # DELETE /contenedores_de_maquinas/1.json
  def destroy
    @contenedor_de_maquinas.destroy
    respond_to do |format|
      format.html { redirect_to contenedores_de_maquinas_url, notice: 'Contenedor de maquinas was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contenedor_de_maquinas
      @contenedor_de_maquinas = ContenedorDeMaquinas.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contenedor_de_maquinas_params
      params.require(:contenedor_de_maquinas).permit(:montaje_id, :maquina_id)
    end
end
