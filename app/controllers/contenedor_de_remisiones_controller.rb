class ContenedorDeRemisionesController < ApplicationController
  before_action :set_contenedor_de_remision, only: [:show, :edit, :update, :destroy]

  # GET /contenedor_de_remisiones
  # GET /contenedor_de_remisiones.json
  def index
    @contenedor_de_remisiones = ContenedorDeRemision.all
  end

  # GET /contenedor_de_remisiones/1
  # GET /contenedor_de_remisiones/1.json
  def show
  end

  # GET /contenedor_de_remisiones/new
  def new
    @contenedor_de_remision = ContenedorDeRemision.new
  end

  # GET /contenedor_de_remisiones/1/edit
  def edit
  end

  # POST /contenedor_de_remisiones
  # POST /contenedor_de_remisiones.json
  def create
    @contenedor_de_remision = ContenedorDeRemision.new(contenedor_de_remision_params)

    respond_to do |format|
      if @contenedor_de_remision.save
        format.html { redirect_to @contenedor_de_remision, notice: 'Contenedor de remision was successfully created.' }
        format.json { render :show, status: :created, location: @contenedor_de_remision }
      else
        format.html { render :new }
        format.json { render json: @contenedor_de_remision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contenedor_de_remisiones/1
  # PATCH/PUT /contenedor_de_remisiones/1.json
  def update
    respond_to do |format|
      if @contenedor_de_remision.update(contenedor_de_remision_params)
        format.html { redirect_to @contenedor_de_remision, notice: 'Contenedor de remision was successfully updated.' }
        format.json { render :show, status: :ok, location: @contenedor_de_remision }
      else
        format.html { render :edit }
        format.json { render json: @contenedor_de_remision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contenedor_de_remisiones/1
  # DELETE /contenedor_de_remisiones/1.json
  def destroy
    @contenedor_de_remision.destroy
    respond_to do |format|
      format.html { redirect_to contenedor_de_remisiones_url, notice: 'Contenedor de remision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contenedor_de_remision
      @contenedor_de_remision = ContenedorDeRemision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contenedor_de_remision_params
      params.require(:contenedor_de_remision).permit(:factura_id, :compromiso_de_entrega_id)
    end
end
