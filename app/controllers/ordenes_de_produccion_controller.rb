class OrdenesDeProduccionController < ApplicationController
  before_action :set_orden_de_produccion, only: [:show, :edit, :update, :destroy]

  # GET /ordenes_de_produccion
  # GET /ordenes_de_produccion.json
  def index
    @ordenes = OrdenDeProduccion.all
  end

  def produccion
    @pedidos = Pedido.joins(:contacto)
    @orden_de_produccion = OrdenDeProduccion.new
  end

  def info_produccion
    @my_produccion = Pedido.joins(:ordenes_de_produccion).find(params[:id])
    render json: @my_produccion.to_json(:include => :ordenes_de_produccion)
  end

  # GET /ordenes_de_produccion/1
  # GET /ordenes_de_produccion/1.json
  def show
    puts "===================================START================================="
      #@ordenes_de_produccion = OrdenDeProduccion.all
      @my_id= params[:id]
      @ped = Pedido.where('pedidos.id ='"#{@my_id}"'')
      @ordenes = OrdenDeProduccion.where('pedido_id ='"#{@my_id}"'')

      puts "****************************************",@ped,"****************************************"
      puts '======================================',@ordenes,'====================='

      #@ped = Pedido.joins(:ordenes_de_produccion).find(params[:id])
      @orden_de_produccion = OrdenDeProduccion.new
      @orden_de_produccion.detalles_de_produccion.build

    puts "===================================GOOD END================================="

  end


  # GET /ordenes_de_produccion/new
  def new
    @orden_de_produccion = OrdenDeProduccion.new
  end

  # GET /ordenes_de_produccion/1/edit
  def edit
  end

  # POST /ordenes_de_produccion
  # POST /ordenes_de_produccion.json
  def create
    @orden_de_produccion = OrdenDeProduccion.new(orden_de_produccion_params)
    @OrdenDeProduccion = OrdenDeProduccion.last
    if @orden_de_produccion.save
      respond_to do |format|
        format.html {redirect_to ordenes_de_produccion_url}
        format.js{}
      end
    end


    #respond_to do |format|
    #  if @orden_de_produccion.save
    #  format.html { redirect_to produccion_url, notice: 'Orden de produccion was successfully created.' }
    #    format.json
    #
    #  else
    #   format.html { render :new }
    #   format.json { render json: @orden_de_produccion.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /ordenes_de_produccion/1
  # PATCH/PUT /ordenes_de_produccion/1.json
  def update
    respond_to do |format|
      if @orden_de_produccion.update(orden_de_produccion_params)
        format.html { redirect_to ordenes_de_produccion_url, notice: 'Orden de produccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @orden_de_produccion }
      else
        format.html { render :edit }
        format.json { render json: @orden_de_produccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordenes_de_produccion/1
  # DELETE /ordenes_de_produccion/1.json
  def destroy
    #@orden_de_produccion.destroy
    @ordenes.destroy
    respond_to do |format|
        format.html {redirect_to ordenes_de_produccion_url}
        format.js{}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden_de_produccion
      #@orden_de_produccion = OrdenDeProduccion.find(params[:id])
      @ordenes=OrdenDeProduccion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_de_produccion_params
      params.require(:orden_de_produccion).permit(:pedido_id, :numero_de_orden,
        :descripcion, :fecha_final, :total, :estado,
      detalles_de_produccion_attributes:[:orden_de_produccion_id, :codigo,
        :descripcion, :cantidad, :fecha, :inventario, :estado])
    end
end
