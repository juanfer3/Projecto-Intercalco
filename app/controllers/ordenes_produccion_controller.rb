class OrdenesProduccionController < ApplicationController
  before_action :set_orden_produccion, only: [:show, :edit, :update, :destroy]

  # GET /ordenes_produccion
  # GET /ordenes_produccion.json
  def index
    @ordenes_produccion = OrdenProduccion.all
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
    @formato_op = FormatoOp.new
    @formato_op.ordenes_produccion.build

    respond_to do |format|
      format.js
    end
  end

  # GET /ordenes_produccion/new
  def new
    @orden_produccion = OrdenProduccion.new
    @formato_op = FormatoOp.new
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
        format.html { redirect_to @orden_produccion, notice: 'Orden produccion was successfully created.' }
        format.json { render :show, status: :created, location: @orden_produccion }
      else
        format.html { render :new }
        format.json { render json: @orden_produccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordenes_produccion/1
  # PATCH/PUT /ordenes_produccion/1.json
  def update
    respond_to do |format|
      if @orden_produccion.update(orden_produccion_params)
        format.html { redirect_to @orden_produccion, notice: 'Orden produccion was successfully updated.' }
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
      params.require(:orden_produccion).permit(:formato_op_id, :numero_de_orden, :mes_id, :cantidad_programada, :precio_unitario, :valor_total, :tipo_de_produccion, :material, :temperatura, :tamanos_total, :cavidad, :fecha, :fecha_compromiso, :cantidad_hoja, :porcentaje_macula, :tiro, :retiro, :observacion, :pantalla, :color, :corte_material, :impresion, :troquel, :acabado, :habilitar_impresion, :habilitar_acabado, :estado_de_orden, :estado)
    end
end
