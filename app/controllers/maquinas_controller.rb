class MaquinasController < ApplicationController
  before_action :set_maquina, only: [:show, :edit, :update, :destroy]
  require 'colorize'

  # GET /maquinas
  # GET /maquinas.json
  def index
    @maquinas = Maquina.all.order("nombre")
    respond_to do |format|
      format.html

    end

  end

  def blur_edit_machine
    cantidad_maquinas = params["cantidad_maquinas"]
    id_programacion = params["id_programacion"]

    if id_programacion.present?
      @programacion_op_maquina = Maquina.update_cantidad_maq_best_in_place(id_programacion,cantidad_maquinas)
    end

    puts"CANTIDAD MAQUINAS:".green

    respond_to do |format|
      format.js
    end
  end

  def programacion_maquinas_excel
    @maquina = Maquina.find(params[:id])
    @op = OrdenProduccion.joins(:montaje =>[:cliente,:contenedores_de_maquinas, :desarrollos_de_tinta]).where("contenedores_de_maquinas.maquina_id= ?", @maquina.id)
    @ordenes_produccion = Maquina.descargar_ordenes_programadas_por_maquina(@maquina.id)
    @ordenes_sin_programar = Maquina.descargar_ordenes_sin_programar_por_maquina(@maquina.id)
    respond_to do |format|
      format.html
      format.xls{
        response.headers['Content-Disposition'] = 'attachment; filename="ProgramacionDeOrdenesPorMaquinas.xls"'
      }
      #format.xlsx {
      #  response.headers['Content-Disposition'] = 'attachment; filename="ProgramacionDeOrdenesPorMaquinas.xlsx"'
      #}
    end
  end


  def buscar_orden_maquina
    #code
    data = params["data"]
    id_maquina = params["id_maquina"]
    puts "*****************ESTE ES EL ID#{id_maquina}***********************".yellow
    @maquina = Maquina.find_by(id: id_maquina)
    if @maquina == nil
      puts "=============================ESTA VACIO=========================="
    end

    @ordenes_produccion = Maquina.buscador_de_ordenes_por_maquina(data)
    respond_to do |format|
      format.js
    end
  end


  def confirmar_impresion
    #code
    @orden_produccion = OrdenProduccion.find(params[:id])
    if @orden_produccion.impresion == true
      @orden_produccion.update(impresion:false)
    else
      @orden_produccion.update(impresion:true)
    end
    respond_to do |format|
      format.js
    end
  end

  def detalles_produccion_maquina
    #Detalles produccion maquina
    puts "****************************************"
    @orden_produccion = OrdenProduccion.find(params[:id])
    @programacion_op_maquina = ProgramacionOpMaquina.new
    respond_to do |format|
      format.js
    end
  end

  def consulta_por_maquinas
    #code
    puts "==============CONSULTA DE MAQUINAS===================="
    estado = true
    @maquinas = Maquina.where("estado = ?", estado).order("nombre")
    @maquina = Maquina.find(params[:id])
    estado_impresion = false
    sacar_de_inventario = false
    @ordenes_produccion = OrdenProduccion.joins(:montaje =>[:cliente,:contenedores_de_maquinas]).paginate(page: params[:page], per_page: 20).where("contenedores_de_maquinas.maquina_id= ? AND ordenes_produccion.impresion = ? AND ordenes_produccion.sacar_de_inventario = ?", @maquina.id, estado_impresion, sacar_de_inventario)
    respond_to do |format|
      format.js
      format.html { render :template =>'maquinas/produccion_por_maquinas'}
    end
  end

  def produccion_por_maquinas
    #code
    rol = current_user.rol_id
    estado = true
    @maquinas = Maquina.joins(:habilitar_rol_maquinas).where("habilitar_rol_maquinas.rol_id= ?", rol).order("nombre")
    @ordenes_produccion = []
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
    @maquina.habilitar_rol_maquinas.build
    estado = true
    @roles = Rol.where("administrador_maquina = ?", estado).order("cargo")
  end

  # GET /maquinas/1/edit
  def edit

    estado = true
    @roles = Rol.where("administrador_maquina = ?", estado).order("cargo")
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
      params.require(:maquina).permit(:nombre, :descripcion, :unidad,
        :formato_de_tamaño,:estado,:tirajes_por_hora, :rol_ids => [],
      habilitar_rol_maquinas_attributes: [:id,:_destroy,:maquina_id, :rol_id, :rol_ids => []]
      )
    end
end
