class OrdenesProduccionController < ApplicationController
  before_action :set_orden_produccion, only: [:show, :edit, :update, :destroy]

  require 'colorize'

  # GET /ordenes_produccion
  # GET /ordenes_produccion.json
  def index
    hoy = Time.now
    entregado = false

  @ordenes_produccion = OrdenProduccion.joins(:compromisos_de_entrega).paginate(page: params[:page], per_page: 20).where("compromisos_de_entrega.fecha_de_compromiso >= ? AND ordenes_produccion.entregado = ?", hoy, entregado).order("compromisos_de_entrega.fecha_de_compromiso")
  todas_las_ordenes = OrdenProduccion.joins(:montaje).where("ordenes_produccion.entregado = ?", entregado).order("ordenes_produccion.numero_de_orden")
  @ordenes_prioridad = OrdenProduccion.joins(:compromisos_de_entrega, :montaje).where("compromisos_de_entrega.fecha_de_compromiso < ? AND   ordenes_produccion.entregado = ?", hoy,entregado).order("compromisos_de_entrega.fecha_de_compromiso").distinct

   @ordenes_sin_fecha = []
   #iteracion 1
   todas_las_ordenes = todas_las_ordenes.sort_by{|a| a.compromisos_de_entrega.sort_by{|b| b["fecha_de_compromiso"].to_s.split('/') } }

   todas_las_ordenes.each do |op|
           #if 2
           puts "********************interando ordenes********************".green

          if op.compromisos_de_entrega.empty?
             puts "*****************Numero de orde : #{op.numero_de_orden}**********************".yellow
             @ordenes_sin_fecha << op
          else



            #if 1
          end

       #iteracion 1
     end


    respond_to do |format|
      format.html
      format.js
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="OrdenesDeProduccion.xlsx"'
      }
    end
  end




  def open_modal_import
    #code
    respond_to do |format|
      format.js
    end
  end


def busquda_avanzada_produccion
  estado = params["estados"]
  cliente = params["clientes"]
  mes = params["mes"]

  if mes == "Ninguno"
    mes = ""
  end

  if estado == "Ninguno"
    cliente = ""
  end



  puts "**************** Cliente: #{cliente}**********************".yellow
  puts "****************ESTADO VALUE: #{estado}**********************".green


  respond_to do |format|
    if mes.present? && cliente.present? && estado.present?
          puts "======<(*)========START==========(*)>========="
          puts "................"
          puts "............................."
          puts "....................................."
          @mes = mes
          @compromisos_de_entrega = OrdenProduccion.consultar_mes_cliente_estado(@mes,cliente,estado)
          format.js { render :template =>'ordenes_produccion/buscador_de_ordenes_por_mes.js'}

    elsif mes.present? && cliente.present?
      @mes = mes
      @compromisos_de_entrega = OrdenProduccion.consultar_mes_cliente(@mes,cliente)
      format.js { render :template =>'ordenes_produccion/buscador_de_ordenes_por_mes.js'}

   elsif mes.present? && estado.present?
     puts "*****************SOLO TIENE MES Y ESTADO***********************".green
     puts "===============================================================".yellow
     @mes = mes
     @compromisos_de_entrega = OrdenProduccion.consultar_mes_estado(@mes,estado)
     format.js { render :template =>'ordenes_produccion/buscador_de_ordenes_por_mes.js'}


    else
          if cliente.present?
            @ordenes = OrdenProduccion.advanced_search_cliente_estado(estado, cliente)
            format.js
          elsif mes.present?
            @mes = mes
            @compromisos_de_entrega = OrdenProduccion.consultar_mes(@mes)
            format.js { render :template =>'ordenes_produccion/buscador_de_ordenes_por_mes.js'}


          else
            @ordenes = OrdenProduccion.advanced_search_estado(estado)
            format.js{ render }
          end
    end





  end
end



def cargar_select_advance_search
  #code
  data = params['q']
  puts "******************ESTA ES LA DATA: #{data}**********************".red
  val_estado = true
  @clientes = []
  @clientes= Cliente.where("nombre ILIKE ? AND estado = ?", data+"%", val_estado).order('nombre') if data.present?
  respond_to do |format|
    format.js
    format.json
  end
end




def produccion_coordinador
  #code
  hoy = Time.now
  entregado = false

@ordenes_produccion = OrdenProduccion.joins(:compromisos_de_entrega).paginate(page: params[:page], per_page: 20).where("compromisos_de_entrega.fecha_de_compromiso >= ? AND ordenes_produccion.entregado = ?", hoy, entregado).order("compromisos_de_entrega.fecha_de_compromiso").distinct
todas_las_ordenes = OrdenProduccion.joins(:montaje).where("ordenes_produccion.entregado = ?", entregado).order("ordenes_produccion.numero_de_orden")
@ordenes_prioridad = OrdenProduccion.joins(:compromisos_de_entrega, :montaje).where("compromisos_de_entrega.fecha_de_compromiso < ? AND   ordenes_produccion.entregado = ?", hoy,entregado).order("compromisos_de_entrega.fecha_de_compromiso").distinct

 @ordenes_sin_fecha = []
 #iteracion 1
 todas_las_ordenes = todas_las_ordenes.sort_by{|a| a.compromisos_de_entrega.sort_by{|b| b["fecha_de_compromiso"].to_s.split('/') } }

 todas_las_ordenes.each do |op|
         #if 2
        puts "********************interando ordenes********************".green
        if op.compromisos_de_entrega.empty?
           puts "*****************Numero de orde : #{op.numero_de_orden}**********************".yellow
           @ordenes_sin_fecha << op
        else
          #if 1
        end

     #iteracion 1
   end


  respond_to do |format|
    format.html
    format.js
    format.xlsx {
      response.headers['Content-Disposition'] = 'attachment; filename="OrdenesDeProduccion.xlsx"'
    }
  end
end

def   info_coordinador
  #code
  @orden_produccion = OrdenProduccion.find(params[:id])
  respond_to do |format|
    format.html
    format.js
  end
end

def cerrar_materiales
  #code
  @orden_produccion = OrdenProduccion.find(params[:id])
  respond_to do |format|
    if @orden_produccion.corte_material == false
          @orden_produccion.update(corte_material: true)
          format.js {flash[:notice] = "" }
    else
      @orden_produccion.update(corte_material: false)
      format.js {flash[:notice] = "" }
    end
  end
end



  def reporte_tinta

    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf {render template: "ordenes_produccion/reporte_tinta", pdf: 'reporte_tinta'}
      format.json
    end
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
  #importaciones
  file = params[:file]
  montaje_seleccionado = params["seleccion_montaje_id"]
  linea_de_producto_seleccionada = params["seleccion_linea_de_producto_id"]
  linea_de_color_seleccionada = params["seleccion_linea_de_color_id"]
  cliente_id = ""
  maquinas_seleccionadas = []
  maquinas_seleccionadas = params["seleccion_maquina_id"]

  seleccion_acabados = []
  seleccion_acabados = params["seleccion_acabados"]

  comercial_id = params["comercial_id"]
  inventario = params["inventario"]
  fecha_de_orden = params["fecha_op"]
  fecha_compromiso = params["fecha_compromiso"]
  agregar_acabados = params["agregar_acabados"]

  if inventario == "yes"
    inventario = true
  else
    inventario = false
  end



  puts "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°".red
  puts "***************Este es el montaje id: #{montaje_seleccionado}*************************".green
  puts "***************Este es el Linea producto id: #{linea_de_producto_seleccionada}*************************".green
  puts "***************Este es el linea de color id: #{linea_de_color_seleccionada}*************************".green
  puts "***************Estas son las maquinas ids: #{maquinas_seleccionadas}*************************".green
  puts "***************Este es el id del Cliente id #{cliente_id}*************************".green
  puts "***************Este es el estado del inventario #{inventario}*************************".green
  puts "***************Esta es la fecha de orden #{fecha_de_orden}*************************".green
  puts "***************AGREGAR ACABADOS:  #{agregar_acabados}*************************".green
  puts "***************SELECIONAR ACABADOS: #{seleccion_acabados}*************************".green
  puts "***************ESTE ES EL COMERCIAL SELECCIONADDO #{comercial_id}*************************".green
  puts "***************ESTA ES LA FECHA DE COPROMISO #{fecha_compromiso}*************************".green
  puts "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°".red


  begin
    errores_o_true = OrdenProduccion.importar_excel_individual(file,montaje_seleccionado,
      linea_de_producto_seleccionada,linea_de_color_seleccionada,maquinas_seleccionadas,comercial_id,
      inventario, fecha_de_orden, agregar_acabados, seleccion_acabados, cliente_id, fecha_compromiso)

    respond_to do |format|
      if errores_o_true == true
        format.html { redirect_to ordenes_produccion_path, notice: 'Ordenes Importados' }
        format.json { render :show, status: :created, location: @orden_produccion }
        format.js
      else
        @errores = errores_o_true
        format.html { render ordenes_produccion_path, notice: 'Orden de produccion importada'}

      end
  end
  rescue Exception => e
    flash[:notice] = errores_o_true
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
    estado = true
    @ordenes_produccion = OrdenProduccion.where("habilitar_impresion = ?", estado).order("numero_de_orden DESC")
    respond_to do |format|
      format.html
      format.pdf {render template: "ordenes_produccion/color_pdf", pdf: 'color_pdf'}
      format.json
    end

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
    estado = true
    @ordenes_produccion = OrdenProduccion.where("habilitar_impresion = ?", estado).order("numero_de_orden DESC")
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
      params.require(:orden_produccion).permit(:montaje_id,:contacto_id,:numero_de_orden,:contacto,:orden_de_compra,:orden_nueva,:habilitar_corte_de_material,
        :cantidad_programada, :precio_unitario, :valor_total, :tipo_de_produccion,:facturar_a,:direccion_nueva, :facturar_a_nuevo,:sacar_de_inventario,
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
