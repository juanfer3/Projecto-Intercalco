class ProcesosMaquinasController < ApplicationController
  before_action :set_proceso_maquinas, only: [:show, :edit, :update, :destroy]

  # GET /procesos_maquinas
  # GET /procesos_maquinas.json
  def index
    @procesos_maquinas = ProcesoMaquinas.all
  end


  # Cambiar ProcesoMaquinas
  def change_proceso_maquina
    @proceso_maquinas = ProcesoMaquinas.find(params[:id])
    if @proceso_maquinas.cerrado == true
      @proceso_maquinas.update(cerrado: false)
    else
      @proceso_maquinas.update(cerrado: true)
    end

    @orden = OrdenProduccion.find_by(id:@proceso_maquinas.orden_produccion_id)
    cont = 0

    @orden.procesos_maquinas.each do |proceso|
      if proceso.cerrado == true
        cont =cont += 1
      end
    end

    if @orden.procesos_maquinas.length == cont
      @orden.update(impresion:true)
    else
      @orden.update(impresion:false)
    end

  end

  # GET /procesos_maquinas/1
  # GET /procesos_maquinas/1.json
  def show
  end

  # GET /procesos_maquinas/new
  def new
    @proceso_maquinas = ProcesoMaquinas.new
  end

  # GET /procesos_maquinas/1/edit
  def edit
  end

  # POST /procesos_maquinas
  # POST /procesos_maquinas.json
  def create
    @proceso_maquinas = ProcesoMaquinas.new(proceso_maquinas_params)

    respond_to do |format|
      if @proceso_maquinas.save
        format.html { redirect_to @proceso_maquinas, notice: 'Proceso maquinas was successfully created.' }
        format.json { render :show, status: :created, location: @proceso_maquinas }
      else
        format.html { render :new }
        format.json { render json: @proceso_maquinas.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procesos_maquinas/1
  # PATCH/PUT /procesos_maquinas/1.json
  def update
    respond_to do |format|
      if @proceso_maquinas.update(proceso_maquinas_params)
        format.html { redirect_to @proceso_maquinas, notice: 'Proceso maquinas was successfully updated.' }
        format.json { render :show, status: :ok, location: @proceso_maquinas }
      else
        format.html { render :edit }
        format.json { render json: @proceso_maquinas.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procesos_maquinas/1
  # DELETE /procesos_maquinas/1.json
  def destroy
    @proceso_maquinas.destroy
    respond_to do |format|
      format.html { redirect_to procesos_maquinas_url, notice: 'Proceso maquinas was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proceso_maquinas
      @proceso_maquinas = ProcesoMaquinas.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proceso_maquinas_params
      params.require(:proceso_maquinas).permit(:orden_produccion_id, :contenedor_de_maquinas_id, :cerrado)
    end
end
