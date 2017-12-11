class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]

  # GET /pedidos
  # GET /pedidos.json
  def index
    @pedidos = Pedido.all
  end

  def consultar_despacho
    @pedido = Pedido.new
    @pedido.tiempos_de_entregas.build
    @pedido.despachos.build

      respond_to do |format|
      if @pedido = Pedido.find(params[:id])
        @tiempos_de_entrega = TiemposDeEntrega.where("pedido_id=#{@pedido}")

        format.js {flash[:notice] = "" }
      end
    end
  end

  def entregas
    @pedidos = Pedido.all
    @pedido = Pedido.new
    @pedido.tiempos_de_entregas.build
    @tiempos_de_entrega = TiemposDeEntrega.new
  end

  def produccion
    @pedidos = Pedido.joins(:contacto)
    @orden_de_produccion = OrdenDeProduccion.new
  end

  def multiple
   @pedidos = Pedido.find(params[:pedido_ids])
   #@users.each do |pedido|
   #   pedido.update_attributes!(params[:user].reject { |k,v| v.blank? })
   #end
   flash[:notice] = "Users Updated!"
   #redirect_to admin_users_path
  end


  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
    @orden_de_produccion = OrdenDeProduccion.new
  end

  # GET /pedidos/new
  def new
    @pedido = Pedido.new
    @pedido.tiempos_de_entregas.build
    @pedido.despachos.build

  end

  # GET /pedidos/1/edit
  def edit
    @pedido.tiempos_de_entregas.build
    @pedido.despachos.build
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(pedido_params)

    respond_to do |format|
      if @pedido.save
        format.html { redirect_to pedidos_url, notice: 'Pedido was successfully created.' }
        format.json { render :index, status: :created, location: @pedido }
      else
        format.html { render :new }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update
    respond_to do |format|
      if @pedido.update(pedido_params)
        format.html { redirect_to pedidos_url, notice: 'Pedido was successfully updated.' }
        format.json { render :show, status: :ok, location: @pedido }
      else
        format.html { render :edit }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido.destroy
    respond_to do |format|
      format.html { redirect_to action: :index, notice: 'Pedido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end
    def rol_params
      params.require(:rol).permit(:cargo, :estado)
    end
    def set_rol
      @rol = Rol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      params.require(:pedido).permit(:contacto_id,
      :producto, :tipo_de_trabajo,
      :condicion_de_pedido, :fecha_entrega,
      :fecha_de_pedido, :numero_cotizacion,
      :numero_de_pedido, :linea_de_impresion_id,
      :forma_de_pago, :arte, :descripcion, :total_articulo,
      :estado_pedido, :estado,
      tiempos_de_entregas_attributes:[:pedido_id, :remision, :cantidad, :fecha_compromiso, :precio, :fecha_de_despacho, :cantidad_enviada, :precio_a_facturar, :cantidad_faltante, :anexo, :entrega_cumplida, :estado],
      despachos_attributes:[:pedido_id, :nombre, :nit, :telefono, :lugar_de_despacho, :direccion, :celular, :correo, :recibe, :observacion, :facturar, :entregar_factura, :estado],
      ordenes_de_produccion_attributes:[:pedido_id, :descripcion,  :codigo, :total, :cantidad, :fecha,:inventario,:estado])
    end




end
