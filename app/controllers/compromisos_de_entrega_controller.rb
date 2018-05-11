class CompromisosDeEntregaController < ApplicationController
  before_action :set_compromiso_de_entrega, only: [:show, :edit, :update, :destroy]

  # GET /compromisos_de_entrega
  # GET /compromisos_de_entrega.json
  def index
    @compromisos_de_entrega = CompromisoDeEntrega.all.paginate(page: params[:page], per_page: 20).order('fecha_de_compromiso DESC')
  end

  def abrir_form_formato_de_oportunidad
    @lineas_productos = LineaProducto.all.order("nombre")
    @lineas = []

    @lineas_productos.each do  |linea|
      contenido = ["id",linea.id,"nombre",linea.nombre]
      @lineas << Hash[*contenido]
    end
    contenido2 = ["id" , "todas", "nombre" , "TODAS"]
    @lineas << Hash[*contenido2]
    @lineas.each do  |linea|
      puts"================ lineas: #{linea}==============".green
    end
    respond_to do |format|

      format.js

    end
  end

  def export_formato_de_pendientes_facturacion
    @datos_informe = CompromisoDeEntrega.generador_informe_de_pendientes_por_facturar
    respond_to do |format|

      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="PendientesPorFacturar.xlsx"'
      }

    end

  end


  def abrir_form_formato_de_pendientes_por_facturar
    @lineas_productos = LineaProducto.all.order("nombre")
    respond_to do |format|

      format.js

    end
  end




  def habilitar_facturacion
    #HABILITAR FACTURACION
    @orden_produccion = OrdenProduccion.find(params[:id])

    respond_to do |format|
      if @orden_produccion.facturado == true
            @orden_produccion.update(facturado: false)
            format.js {flash[:notice] = "" }
      else
            @orden_produccion.update(facturado: true)
            format.js {flash[:notice] = "" }
      end
    end

  end

  def export_formato_de_oportunidad
    fecha_inicial = params["fecha_inicial"]
    fecha_final = params["fecha_final"]
    linea_producto = params["linea_producto_id"]
    todo = params ["tod"]

    puts"=======================".yellow
    puts"#{fecha_inicial}".blue
    puts"#{fecha_final}".blue
    puts"#{linea_producto}".blue
    puts"#{todo}".blue
    puts"=======================".yellow

    if todo == true
      @datos_informe = CompromisoDeEntrega.generador_informe_de_oportunidad(fecha_inicial, fecha_final, linea_producto)
    else
      @datos_informe = CompromisoDeEntrega.generador_informe_de_oportunidad_todas_las_lineas(fecha_inicial, fecha_final)
    end

    respond_to do |format|


      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="IndicadorOportunidad.xlsx"'
      }

    end

  end




  def buscador_de_ordenes_despachos
    #code
    data = params['data']
    CompromisoDeEntrega.buscador_de_ordenes(data)
    puts "****************El dato es #{data}************************"
    respond_to do |format|
      format.js
    end
  end


  def deshacer_envio
    @compromiso_de_entrega = CompromisoDeEntrega.find(params[:id])
    respond_to do |format|
        @compromiso_de_entrega.update(enviado: false,
          fecha_despacho: "", cantidad_despacho:0.0, numero_de_remision:"", observacion: "")
          @compromiso_de_entrega = CompromisoDeEntrega.find(params[:id])
          @orden_produccion = OrdenProduccion.find_by(id: @compromiso_de_entrega.orden_produccion_id)

            puts"=========================#{@orden_produccion.compromisos_de_entrega}==============================".red


        format.js {flash[:notice] = "" }
    end
    respond_to do |format|
      format.js
    end
  end

  # GET /compromisos_de_entrega/1
  # GET /compromisos_de_entrega/1.json
  def show
  end

  # GET /compromisos_de_entrega/new
  def new
    @compromiso_de_entrega = CompromisoDeEntrega.new
  end

  # GET /compromisos_de_entrega/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /compromisos_de_entrega
  # POST /compromisos_de_entrega.json
  def create
    @compromiso_de_entrega = CompromisoDeEntrega.new(compromiso_de_entrega_params)

    respond_to do |format|
      if @compromiso_de_entrega.save

        format.html { redirect_to @compromiso_de_entrega, notice: 'Compromiso de entrega was successfully created.' }
        format.json { render :show, status: :created, location: @compromiso_de_entrega }
      else
        format.html { render :new }
        format.json { render json: @compromiso_de_entrega.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compromisos_de_entrega/1
  # PATCH/PUT /compromisos_de_entrega/1.json
  def update
    respond_to do |format|
      if @compromiso_de_entrega.update(compromiso_de_entrega_params)
        @compromiso_de_entrega = CompromisoDeEntrega.find(params[:id])
        @orden_produccion = OrdenProduccion.find_by(id: @compromiso_de_entrega.orden_produccion.id)
        format.html { redirect_to @compromiso_de_entrega, notice: 'Compromiso de entrega was successfully updated.' }
        format.json { render :show, status: :ok, location: @compromiso_de_entrega }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @compromiso_de_entrega.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /compromisos_de_entrega/1
  # DELETE /compromisos_de_entrega/1.json
  def destroy
    @compromiso_de_entrega.destroy
    respond_to do |format|
      format.html { redirect_to compromisos_de_entrega_url, notice: 'Compromiso de entrega was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compromiso_de_entrega
      @compromiso_de_entrega = CompromisoDeEntrega.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compromiso_de_entrega_params
      params.require(:compromiso_de_entrega).permit(:orden_produccion_id, :fecha_de_compromiso,
        :cantidad, :precio, :fecha_despacho, :cantidad_despacho, :precio_despacho,:observacion,
        :diferencia, :numero_de_remision,:enviado, :cumplido,:estado)
    end
end
