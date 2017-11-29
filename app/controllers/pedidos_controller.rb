class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]

  # GET /pedidos
  # GET /pedidos.json
  def index
    @pedidos = Pedido.all
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
    
  end

  # GET /pedidos/new
  def new
    @pedido = Pedido.new
    @pedido.tiempos_de_entregas.build
    @pedido.despachos.build
  end

  # GET /pedidos/1/edit
  def edit
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(pedido_params)

    respond_to do |format|
      if @pedido.save
        format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
        format.json { render :show, status: :created, location: @pedido }
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
        format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
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
      format.html { redirect_to pedidos_url, notice: 'Pedido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
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
      tiempos_de_entregas_attributes:[:pedido_id, :cantidad, :fecha_compromiso, :precio, :estado],
      despachos_attributes:[:pedido_id, :nombre, :nit, :telefono, :lugar_de_despacho, :direccion, :celular, :correo, :recibe, :observacion, :facturar, :entregar_factura, :estado],
      ordenes_de_produccion_attributes:[:pedido_id, :descripcion, :fecha_final, :total, :estado])
    end
    
   
    
end
