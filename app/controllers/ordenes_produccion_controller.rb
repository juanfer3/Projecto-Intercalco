class OrdenesProduccionController < ApplicationController
  before_action :set_orden_produccion, only: [:show, :edit, :update, :destroy]

  # GET /ordenes_produccion
  # GET /ordenes_produccion.json
  def index
    @ordenes_produccion = OrdenProduccion.all.paginate(page: params[:page], per_page: 20).order('numero_de_orden').distinct
  end

  def buscador_de_ordenes_por_fecha

    @fecha = params["fecha"]
    @compromisos_de_entrega = OrdenProduccion.consultar_fecha(@fecha)
  end


  def buscador_de_ordenes_por_mes
    @mes = params["mes"]
    @compromisos_de_entrega = OrdenProduccion.consultar_mes(@mes)

  end

  def buscador_de_ordenes
    @data = params['data']
    puts "*****************el dato es: #{@data}***********************"
    @orden= []
    @ordenes= OrdenProduccion.joins(:montaje).where('numero_de_orden ILIKE ?', @data+'%').distinct

    if @ordenes.empty?
      puts "******************Vacio**********************"
      @ordenes= OrdenProduccion.joins(:montaje).where('montajes.nombre ILIKE ?', '%'+@data+'%').distinct
      if @ordenes.empty?
        puts "*****************El montaje no existe***********************"
        @ordenes= OrdenProduccion.joins(:montaje => [:cliente]).where('clientes.nombre ILIKE ?', @data+'%').distinct
        if @ordenes.empty?
          puts "*****************El cliente no existe***********************"
          @ordenes= OrdenProduccion.joins(:montaje => [:linea_producto]).where('lineas_productos.nombre ILIKE ?', @data+'%').distinct

          if @ordenes.empty?
            @ordenes= OrdenProduccion.joins(:montaje => [:linea_de_color]).where('linea_de_colores.nombre ILIKE ?', @data+'%').distinct
          end
        else
          puts "*****************el cliente existe***********************"
        end
      else
        puts "*****************el montaje existe***********************"
      end
    else

    end





    respond_to do |format|
          format.js
    end

  end

def import_ordenes_produccion_from_excel

  file = params[:file]
  begin
    errores_o_true = OrdenProduccion.subir_excel(file)

    respond_to do |format|
      if errores_o_true == true
        format.html { redirect_to ordenes_produccion_path, notice: 'Ordenes Importados' }
        format.json { render :show, status: :created, location: @orden_produccion }
        format.js
    else
        @errores = errores_o_true
        format.html { render ordenes_produccion_path}
        format.js
      end
  end
  rescue Exception => e
    flash[:notice] = "Tipo de archivo no valido"
    redirect_to ordenes_produccion_path
  end
end
  def desarrollar_tintas_retiro
    #code
    @montaje = Montaje.find(params[:id])
    @tinta_fop_retiro = TintaFopRetiro.new

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
      format.js
    end
  end


  def desarrollar_tintas_tiro
    @montaje = Montaje.find(params[:id])
    @tinta_fop_tiro = TintaFopTiro.new

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
      format.js
    end
  end


  def desarrollar_color
    @desarrollo_de_tinta = DesarrolloDeTinta.find(params[:id])
    @tinta_formulada = TintaFormulada.new
    @tinta_formulada.formulas_tinta.build
    @tinta_formulada.transiciones.build
    respond_to do |format|
      format.js
    end

  end

  #Color
  def produccion_color
    @ordenes_produccion = OrdenProduccion.all
  end

  def cerrar_color
    #code
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.color== false
            @orden_produccion.update(color: true)
            format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(color: false)
        format.js {flash[:notice] = "" }
      end
    end
  end

  def info_color
    #code
    @orden_produccion = OrdenProduccion.find(params[:id])


    @Tintas_tiro=[]
    @Tintas_retiro=[]


    @orden_produccion.montaje.tintas_fop_tiro.each do |tintas_tiro|

        @busq_tinta = Tinta.joins(:linea_de_color).find_by(descripcion: tintas_tiro.descripcion)

        if @busq_tinta == nil
          @formula_tintas = TintaFormulada.joins(:linea_de_color).find_by(descripcion: tintas_tiro.descripcion)

          @Tintas_tiro << @formula_tintas

        else

          @Tintas_tiro << @busq_tinta

        end
    end

    @orden_produccion.montaje.tintas_fop_retiro.each do |tintas_retiro|

        @busq2_tinta = Tinta.joins(:linea_de_color).find_by(descripcion: tintas_retiro.descripcion)
        puts "******************#{@busq2_tinta}**********************"
        if @busq2_tinta == nil
          puts "******************Esta Vacio**********************"
          @formula2_tintas = TintaFormulada.joins(:linea_de_color).find_by(descripcion: tintas_retiro.descripcion)

          @Tintas_retiro << @formula2_tintas

        else
          puts "******************Esta Vacio**********************"
          @Tintas_retiro << @busq2_tinta


        end

    end


    respond_to do |format|
      format.html
      format.js
    end
  end




  #pantallas
  def produccion_pantallas
    @ordenes_produccion = OrdenProduccion.all
  end

  def cerrar_pantalla
    #code
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.pantalla== false
            @orden_produccion.update(pantalla: true)

            format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(pantalla: false)

        format.js {flash[:notice] = "" }
      end
    end
  end

  def info_pantallas
    #code
    @orden_produccion = OrdenProduccion.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def select_buscar_montaje
    @montaje = Montaje.find(params[:id])
    buscar = "SIN DEFINIR"
    @cliente = Cliente.find_by(nombre: buscar)
    respond_to do |format|
      format.js
    end
  end

  def buscar_fop
    @formatos_op = FormatoOp.joins(:cliente,:montaje).find(params[:id])
    render json: @formatos_op .to_json(:include => :cliente)
  end

  # GET /ordenes_produccion/1
  # GET /ordenes_produccion/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end


  def cambiar_proceso
    respond_to do |format|
      if@orden_produccion = OrdenProduccion.find(params[:id])
        @ordenes_produccion = OrdenProduccion.all
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_habilitar_acabado
    @orden_produccion = OrdenProduccion.find(params[:id])
    respond_to do |format|
      if@orden_produccion.habilitar_acabado == false
        @orden_produccion.update(habilitar_acabado: true, acabado:false)
        puts "==========="+@orden_produccion.habilitar_acabado.to_s+"=========="
        format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(habilitar_acabado: false, acabado:false)
        puts "==========="+@orden_produccion.habilitar_acabado.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_habilitar_impresion
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if@orden_produccion.habilitar_impresion == false
        @orden_produccion.update(habilitar_impresion: true, impresion:false, color:false, pantalla:false, corte_material:false)
        puts "==========="+@orden_produccion.habilitar_impresion.to_s+"=========="
        format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(habilitar_impresion: false, impresion: false, color:false, pantalla:false, corte_material:false)
        puts "==========="+@orden_produccion.habilitar_impresion.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_acabados
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.acabado== false
            @orden_produccion.update(acabado: true)
            puts "==========="+@orden_produccion.acabado.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(acabado: false)
        puts "==========="+@orden_produccion.acabado.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end


  def cambiar_estado_troquel
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.troquel== false
            @orden_produccion.update(troquel: true)
            puts "==========="+@orden_produccion.troquel.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(troquel: false)
        puts "==========="+@orden_produccion.troquel.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_impresion
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.impresion== false
            @orden_produccion.update(impresion: true)
            puts "==========="+@orden_produccion.impresion.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(impresion: false)
        puts "==========="+@orden_produccion.impresion.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_corte_material
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.corte_material== false
            @orden_produccion.update(corte_material: true)
            puts "==========="+@orden_produccion.corte_material.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(corte_material: false)
        puts "==========="+@orden_produccion.corte_material.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_color
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.color == false
            @orden_produccion.update(color: true)
            puts "==========="+@orden_produccion.color.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(color: false)
        puts "==========="+@orden_produccion.color.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_pantalla
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.pantalla== false
            @orden_produccion.update(pantalla: true)

            format.js {flash[:notice] = "" }
      else
        @orden_produccion.update(pantalla: false)

        format.js {flash[:notice] = "" }
      end
    end
  end

  def cargar_form_formato
    @montaje = Montaje.new
    @montaje.piezas.build
    @montaje.tintas_fop_tiro.build
    @montaje.tintas_fop_retiro.build
    @montaje.formatos_op.build

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
      format.js
      format.html
    end
  end

  # GET /ordenes_produccion/new
  def new
    @orden_produccion = OrdenProduccion.new
    @montaje = Montaje.new
    @orden_produccion.compromisos_de_entrega.build

  end

  # GET /ordenes_produccion/1/edit
  def edit
  end

  # POST /ordenes_produccion
  # POST /ordenes_produccion.json
  def create
    @orden_produccion = OrdenProduccion.new(orden_produccion_params)

    respond_to do |format|
      if @orden_produccion.save
        format.html { redirect_to ordenes_produccion_path, notice: 'Orden produccion was successfully created.' }
        format.json { render :show, status: :created, location: @orden_produccion }
        format.js
      else
        format.html { render :new }
        format.json { render json: @orden_produccion.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /ordenes_produccion/1
  # PATCH/PUT /ordenes_produccion/1.json
  def update
    respond_to do |format|
      if @orden_produccion.update(orden_produccion_params)
        format.html { redirect_to ordenes_produccion_path, notice: 'Orden produccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @orden_produccion }
      else
        format.html { render :edit }
        format.json { render json: @orden_produccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordenes_produccion/1
  # DELETE /ordenes_produccion/1.json
  def destroy
    @orden_produccion.destroy
    respond_to do |format|
      format.html { redirect_to ordenes_produccion_url, notice: 'Orden produccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden_produccion
      @orden_produccion = OrdenProduccion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_produccion_params
      params.require(:orden_produccion).permit(:montaje_id,:contacto_id,:numero_de_orden,:contacto,:orden_de_compra,
        :cantidad_programada, :precio_unitario, :valor_total, :tipo_de_produccion,:facturar_a,:direccion_nueva, :facturar_a_nuevo,
        :material, :temperatura, :tamanos_total, :cavidad, :fecha, :fecha_compromiso,:lugar_despacho,:lugar_despacho_id,:nombre_facturacion,:nombre_facturacion_id,
        :cantidad_hoja, :porcentaje_macula, :tiro, :retiro, :observacion, :pantalla,  :contacto_nuevo,:tomar_cliente, :tomar_usuario,
        :color, :corte_material, :impresion, :troquel, :acabado, :habilitar_impresion,:entregado,:cantidad_solicitada,
        :habilitar_acabado, :estado_de_orden, :estado,:tamano_hoja,:tamano_por_hojas,:tamano_de_corte,:_destroy, :id,:contenedor_prueba => [],:maquina_ids => [],
      compromisos_de_entrega_attributes:[:orden_produccion_id, :fecha_de_compromiso,
        :cantidad, :precio, :fecha_despacho, :cantidad_despacho, :precio_despacho,
        :diferencia, :numero_de_remision, :estado,:_destroy, :id]

      )

    end
end
