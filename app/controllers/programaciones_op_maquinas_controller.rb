class ProgramacionesOpMaquinasController < ApplicationController
  before_action :set_programacion_op_maquina, only: [:show, :edit, :update, :destroy]

  # GET /programaciones_op_maquinas
  # GET /programaciones_op_maquinas.json
  def index
    @programaciones_op_maquinas = ProgramacionOpMaquina.all
  end

  # GET /programaciones_op_maquinas/1
  # GET /programaciones_op_maquinas/1.json
  def show
  end

  # GET /programaciones_op_maquinas/new
  def new
    @programacion_op_maquina = ProgramacionOpMaquina.new
  end

  # GET /programaciones_op_maquinas/1/edit
  def edit
  end

  # POST /programaciones_op_maquinas
  # POST /programaciones_op_maquinas.json
  def create
    @programacion_op_maquina = ProgramacionOpMaquina.new(programacion_op_maquina_params)

    respond_to do |format|
      if @programacion_op_maquina.save
        format.html { redirect_to @programacion_op_maquina, notice: 'Programacion op maquina was successfully created.' }
        format.json { render :show, status: :created, location: @programacion_op_maquina }
        format.js
      else
        format.html { render :new }
        format.json { render json: @programacion_op_maquina.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /programaciones_op_maquinas/1
  # PATCH/PUT /programaciones_op_maquinas/1.json
  def update
    respond_to do |format|
      if @programacion_op_maquina.update(programacion_op_maquina_params)
        format.html { redirect_to @programacion_op_maquina, notice: 'Programacion op maquina was successfully updated.' }
        format.json { render :show, status: :ok, location: @programacion_op_maquina }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @programacion_op_maquina.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /programaciones_op_maquinas/1
  # DELETE /programaciones_op_maquinas/1.json
  def destroy
    @programacion_op_maquina.destroy
    respond_to do |format|
      format.html { redirect_to programaciones_op_maquinas_url, notice: 'Programacion op maquina was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_programacion_op_maquina
      @programacion_op_maquina = ProgramacionOpMaquina.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def programacion_op_maquina_params
      params.require(:programacion_op_maquina).permit(:orden_produccion_id,
        :maquina_id, :total_hora, :hora_inicio, :hora_final, :cantidad_maquinas,
        :tiempo_por_maquina, :tiempo_de_montaje, :tiempo_de_desmontaje, :habilitado,
        :complemento,:tirajes_por_hora,:fecha_de_impresion)
    end
end
