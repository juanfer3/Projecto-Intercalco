class MontajesController < ApplicationController
  before_action :set_montaje, only: [:show, :edit, :update, :destroy]

  # GET /montajes
  # GET /montajes.json
  def index
    @montajes = Montaje.all.paginate(page: params[:page], per_page: 20).order("codigo")
    @NombreTintas = Tinta.all.distinct
    @TintaFormulada = TintaFormulada.all.distinct

    @Tintas=[]

    @NombreTintas.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end

    @TintaFormulada.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end
  end

  def busquedaTintasMontaje
    #code
    @montaje = Montaje.find(params[:id])
    @montajes = Montaje.joins(:tintas_fop_tiro, :tintas_fop_retiro).where("montaje_id = '#{@montaje.id}'")
    render json: @montaje.to_json(:include => [:tintas_fop_tiro, :tintas_fop_retiro])
  end

  def buscar_fop
    @montaje = Montaje.find(params[:id])
    @formato_op = FormatoOp.joins(
      :maquina, :montaje, :linea_de_color, :linea_producto).where("montaje_id = '#{@montaje.id}'")
    render json: @formato_op .to_json(:include => [ :maquina, :montaje, :linea_de_color, :linea_producto])

  end

  def import__MP_from_excel
    file = params[:file]
    begin
      errores_o_true = Montaje.subir_MP_from_excel(file)

      respond_to do |format|
        if errores_o_true == true
          format.js { redirect_to montajes_path, notice: 'Montajes y Piezas Importados Importados' }
          format.json { render :show, status: :created, location: @montaje }
        else
          @errores = errores_o_true
          format.html { render 'vista_subir_excel'}
        end
    end
    rescue Exception => e
      flash[:notice] = "Tipo de archivo no valido"
      redirect_to montajes_path
    end
  end

  def import_montaje_from_excel

    file = params[:file]
    begin
      errores_o_true = Montaje.subir_montaje_from_excel(file)

      respond_to do |format|
        if errores_o_true == true
          format.html { redirect_to montajes_path, notice: 'Montajes Importados' }
          format.json { render :show, status: :created, location: @cliente }
        else
          @errores = errores_o_true
          format.html { render 'vista_subir_excel'}
        end
    end
    rescue Exception => e
      flash[:notice] = "Tipo de archivo no valido"
      redirect_to montajes_path
    end
  end

  # GET /montajes/1
  # GET /montajes/1.json
  def show
    @NombreTintas = Tinta.all.distinct
    @TintaFormulada = TintaFormulada.all.distinct

    @Tintas=[]

    @NombreTintas.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end

    @TintaFormulada.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end
    respond_to do |format|
      format.html
      format.js
    end
  end



  # GET /montajes/new
  def new
    @montaje = Montaje.new
    @montaje.piezas.build
    @montaje.tintas_fop_tiro.build
    @montaje.tintas_fop_retiro.build
    @montaje.formatos_op.build

    @montaje.ordenes_produccion.build.compromisos_de_entrega.build

    @montaje.desarrollos_de_tintas.build





    @NombreTintas = Tinta.all.distinct
    @TintaFormulada = TintaFormulada.all.distinct

    @Tintas=[]

    @NombreTintas.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end

    @TintaFormulada.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end

    render "new"

  end

  # GET /montajes/1/edit
  def edit
    @NombreTintas = Tinta.all.distinct
    @TintaFormulada = TintaFormulada.all.distinct

    @Tintas=[]

    @NombreTintas.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end

    @TintaFormulada.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end
  end

  # POST /montajes
  # POST /montajes.json
  def create
    @NombreTintas = Tinta.all.distinct
    @TintaFormulada = TintaFormulada.all.distinct

    @Tintas=[]

    @NombreTintas.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end

    @TintaFormulada.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end
    @montaje = Montaje.new(montaje_params)
    respond_to do |format|
      if @montaje.save
        format.html { redirect_to montajes_path notice: 'Montaje was successfully created.' }
        format.json { render :show, status: :created, location: @montaje }
      else
        format.html { render :new }
        format.json { render json: @montaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /montajes/1
  # PATCH/PUT /montajes/1.json
  def update
    @NombreTintas = Tinta.all.distinct
    @TintaFormulada = TintaFormulada.all.distinct

    @Tintas=[]

    @NombreTintas.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end

    @TintaFormulada.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end
    respond_to do |format|
      if @montaje.update(montaje_params)
        format.html { redirect_to montajes_path, notice: 'Montaje was successfully updated.' }
        format.json { render :show, status: :ok, location: @montaje }
      else
        format.html { render :edit }
        format.json { render json: @montaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /montajes/1
  # DELETE /montajes/1.json
  def destroy
    @NombreTintas = Tinta.all.distinct
    @TintaFormulada = TintaFormulada.all.distinct

    @Tintas=[]

    @NombreTintas.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end

    @TintaFormulada.each do |nombreTintas|
      @Tintas << nombreTintas.descripcion
    end
    @montaje.destroy
    respond_to do |format|
      format.html { redirect_to montajes_url, notice: 'Informacion de Montaje Destruida.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_montaje

      @montaje = Montaje.find(params[:id])


      @NombreTintas = Tinta.all.distinct
      @TintaFormulada = TintaFormulada.all.distinct

      @Tintas=[]

      @NombreTintas.each do |nombreTintas|
        @Tintas << nombreTintas.descripcion
      end

      @TintaFormulada.each do |nombreTintas|
        @Tintas << nombreTintas.descripcion
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def montaje_params
      params.require(:montaje).permit(:cliente_id, :material,:nombre, :tamano, :dimension,
        :dimension_1, :dimension_2, :codigo, :numero_de_montaje, :tipo_de_unidad,
         :cantidad_total, :observacion, :modo_de_empaque, :fecha_de_creacion,:estado,
         :_destroy, :tiro, :retiro,:precorte,:pretroquelado, :laminado, :troquelado,
         :descalerillado, :plotter, :doming, :descolille,:doblez_calor,:termoformado,
         :estampado_al_calor,:refilado,:perforado, :ojalete, :hilo, :pegado, :ensamblado,
         :otro, :tinta_nueva,:maquina_id, :montaje_id, :linea_de_color_id, :linea_producto_id,:_destroy,
         desarrollos_de_tintas_attributes:[:montaje_id, :linea_de_color_id, :malla_id, :descripción, :cantidad, :estado, :tiro, :retiro],
        piezas_attributes:[:montaje_id, :nombre, :tamano, :tipo_de_unidad, :dimension, :descripcion, :cantidad, :codigo ,:estado, :_destroy],
      tintas_fop_retiro_attributes:[:montaje_id, :tinta, :malla_id, :descripcion, :estado],
      tintas_fop_tiro_attributes:[:montaje_id, :tinta, :malla_id, :descripcion, :estado],
      formatos_op_attributes:[:user_id, :maquina_id, :montaje_id, :pieza_a_decorar_id,
        :referencia_de_orden, :linea_de_color_id, :tipo_de_produccion, :material, :temperatura,
        :tamanos_total, :cavidad, :tipo_de_linea, :cantidad_hoja, :observacion, :linea_producto_id, :estado,
        :tiro, :retiro, :_destroy],
      ordenes_produccion_attributes:[:montaje_id, :numero_de_orden,
        :cantidad_programada, :precio_unitario, :valor_total, :tipo_de_produccion,
        :material, :temperatura, :tamanos_total, :cavidad, :fecha, :fecha_compromiso,
        :cantidad_hoja, :porcentaje_macula, :tiro, :retiro, :observacion, :pantalla,
        :color, :corte_material, :impresion, :troquel, :acabado, :habilitar_impresion,:entregado,
        :habilitar_acabado, :estado_de_orden, :estado,:tamano_hoja,:tamano_por_hojas,:tamano_de_corte,:_destroy,
        compromisos_de_entrega_attributes:[:orden_produccion_id, :fecha_de_compromiso,
          :cantidad, :precio, :fecha_despacho, :cantidad_despacho, :precio_despacho,
          :diferencia, :numero_de_remision, :estado, :_destroy]
      ]

      )

    end
end
