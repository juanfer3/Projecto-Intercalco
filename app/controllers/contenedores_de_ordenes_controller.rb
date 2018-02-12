class ContenedoresDeOrdenesController < ApplicationController
  before_action :set_contenedor_de_ordenes, only: [:show, :edit, :update, :destroy]

  # GET /contenedores_de_ordenes
  # GET /contenedores_de_ordenes.json
  def index
    @contenedores_de_ordenes = ContenedorDeOrdenes.all
  end

  # GET /contenedores_de_ordenes/1
  # GET /contenedores_de_ordenes/1.json
  def show
  end

  # GET /contenedores_de_ordenes/new
  def new
    @contenedor_de_ordenes = ContenedorDeOrdenes.new
  end

  # GET /contenedores_de_ordenes/1/edit
  def edit
  end

  # POST /contenedores_de_ordenes
  # POST /contenedores_de_ordenes.json
  def create
    @contenedor_de_ordenes = ContenedorDeOrdenes.new(contenedor_de_ordenes_params)

    respond_to do |format|
      if @contenedor_de_ordenes.save
        format.html { redirect_to @contenedor_de_ordenes, notice: 'Contenedor de ordenes was successfully created.' }
        format.json { render :show, status: :created, location: @contenedor_de_ordenes }
      else
        format.html { render :new }
        format.json { render json: @contenedor_de_ordenes.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contenedores_de_ordenes/1
  # PATCH/PUT /contenedores_de_ordenes/1.json
  def update
    respond_to do |format|
      if @contenedor_de_ordenes.update(contenedor_de_ordenes_params)
        format.html { redirect_to @contenedor_de_ordenes, notice: 'Contenedor de ordenes was successfully updated.' }
        format.json { render :show, status: :ok, location: @contenedor_de_ordenes }
      else
        format.html { render :edit }
        format.json { render json: @contenedor_de_ordenes.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contenedores_de_ordenes/1
  # DELETE /contenedores_de_ordenes/1.json
  def destroy
    @contenedor_de_ordenes.destroy
    respond_to do |format|
      format.html { redirect_to contenedores_de_ordenes_url, notice: 'Contenedor de ordenes was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contenedor_de_ordenes
      @contenedor_de_ordenes = ContenedorDeOrdenes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contenedor_de_ordenes_params
      params.require(:contenedor_de_ordenes).permit(:factura_id, :orden_produccion_id)
    end
end
