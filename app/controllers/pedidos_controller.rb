class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]

  def cambiar_proceso
    respond_to do |format|
      if@pedido = Pedido.find(params[:id])
        @pedidos = Pedido.all
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_habilitar_acabado
    @pedido = Pedido.find(params[:id])
    @pedidos = Pedido.all
    respond_to do |format|
      if@pedido.habilitar_acabado == false
        @pedido.update(habilitar_acabado: true, acabado:false)
        puts "==========="+@pedido.habilitar_acabado.to_s+"=========="
        format.js {flash[:notice] = "" }
      else
        @pedido.update(habilitar_acabado: false, acabado:false)
        puts "==========="+@pedido.habilitar_acabado.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_habilitar_impresion
    @pedido = Pedido.find(params[:id])
    @pedidos = Pedido.all
    respond_to do |format|
      if@pedido.habilitar_impresion == false
        @pedido.update(habilitar_impresion: true, impresion:false, color:false, pantalla:false, corte_material:false)
        puts "==========="+@pedido.habilitar_impresion.to_s+"=========="
        format.js {flash[:notice] = "" }
      else
        @pedido.update(habilitar_impresion: false, impresion: false, color:false, pantalla:false, corte_material:false)
        puts "==========="+@pedido.habilitar_impresion.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_acabados
    @pedido = Pedido.find(params[:id])
    @pedidos = Pedido.all
    respond_to do |format|
      if @pedido.acabado== false
            @pedido.update(acabado: true)
            puts "==========="+@pedido.acabado.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @pedido.update(acabado: false)
        puts "==========="+@pedido.acabado.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end


  def cambiar_estado_troquel
    @pedido = Pedido.find(params[:id])
    @pedidos = Pedido.all
    respond_to do |format|
      if @pedido.troquel== false
            @pedido.update(troquel: true)
            puts "==========="+@pedido.troquel.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @pedido.update(troquel: false)
        puts "==========="+@pedido.troquel.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_impresion
    @pedido = Pedido.find(params[:id])
    @pedidos = Pedido.all
    respond_to do |format|
      if @pedido.impresion== false
            @pedido.update(impresion: true)
            puts "==========="+@pedido.impresion.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @pedido.update(impresion: false)
        puts "==========="+@pedido.impresion.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_corte_material
    @pedido = Pedido.find(params[:id])
    @pedidos = Pedido.all
    respond_to do |format|
      if @pedido.corte_material== false
            @pedido.update(corte_material: true)
            puts "==========="+@pedido.corte_material.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @pedido.update(corte_material: false)
        puts "==========="+@pedido.corte_material.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_color
    @pedido = Pedido.find(params[:id])
    @pedidos = Pedido.all
    respond_to do |format|
      if @pedido.color== false
            @pedido.update(color: true)
            puts "==========="+@pedido.color.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @pedido.update(color: false)
        puts "==========="+@pedido.color.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end

  def cambiar_estado_pantalla
    @pedido = Pedido.find(params[:id])
    @pedidos = Pedido.all
    respond_to do |format|
      if @pedido.pantalla== false
            @pedido.update(pantalla: true)
            puts "==========="+@pedido.pantalla.to_s+"=========="
            format.js {flash[:notice] = "" }
      else
        @pedido.update(pantalla: false)
        puts "==========="+@pedido.pantalla.to_s+"=========="
        format.js {flash[:notice] = "" }
      end
    end
  end
  # GET /pedidos
  # GET /pedidos.json
  def index
    if current_user.rol.cargo == "Administrador"
    @pedidos = Pedido.all.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="pedidos.xlsx"'
      }
    end

    elsif current_user.rol.cargo == "Gerente Comercial"
      @pedidos = Pedido.all.paginate(page: params[:page], per_page: 10)
      respond_to do |format|
        format.html
        format.js
        format.xlsx {
          response.headers['Content-Disposition'] = 'attachment; filename="pedidos.xlsx"'
        }
      end
    elsif current_user.rol.cargo == "Comercial"
      @pedidos = Pedido.all.paginate(page: params[:page], per_page: 10).where("user_id=#{current_user.id}")
      respond_to do |format|
        format.html
        format.js
        format.xlsx {
          response.headers['Content-Disposition'] = 'attachment; filename="pedidos.xlsx"'
        }
      end
    elsif current_user.rol.cargo == "Producción"
      @pedidos = Pedido.all.paginate(page: params[:page], per_page: 10)
      respond_to do |format|
        format.html
        format.js
        format.xlsx {
          response.headers['Content-Disposition'] = 'attachment; filename="pedidos.xlsx"'
        }
      end
    end
  end

#Generar Reportes
  def genera_reporte_pedido
    @pedidos = Pedido.joins(:tiempos_de_entrega, :factura,:facturas_despacho).distinct
    respond_to do |format|
      format.html
      format.js
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="pedidos.xlsx"'
      }
    end
  end


#Cambiar Estado
  def cambiar_estado
    respond_to do |format|
      if@pedido = Pedido.find(params[:id])
        @pedido.update(estado_pedido: "En Producción")
        format.js {flash[:notice] = "" }
      end
    end
  end

#Cambiar Estado A Pedido
  def cambiar_estado_a_Pedido
    respond_to do |format|
      if@pedido = Pedido.find(params[:id])
        @pedido.update(estado_pedido: "Pedido")
        format.js {flash[:notice] = "" }
      end
    end
  end

#Consultas Despachos
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

#Pag entregas
  def entregas
    @pedidos = Pedido.all
    @pedido = Pedido.new
    @pedido.tiempos_de_entregas.build
    @tiempos_de_entrega = TiemposDeEntrega.new
  end

#Pag Producción
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
    respond_to do |format|
      format.html
      format.js
      nombre_archivo = "Pedido #{@pedido.descripcion}.xlsx"
      format.xlsx {
      response.headers['Content-Disposition'] = 'attachment; filename='+nombre_archivo
      }
    end
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
    @pedido = current_user.pedidos.new(pedido_params)

    respond_to do |format|
      if @pedido.save
        format.html { redirect_to pedidos_url, notice: 'Pedido Creado Con exito.' }
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
        format.html { redirect_to pedidos_url, notice: 'Cambios Realizados' }
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
      format.html { redirect_to action: :index, notice: 'El Pedido A Sido Eliminado' }
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
      params.require(:pedido).permit(:contacto_id,:user_id,
      :producto, :tipo_de_trabajo,
      :condicion_de_pedido, :fecha_entrega,
      :fecha_de_pedido, :numero_cotizacion,
      :numero_de_pedido, :linea_de_impresion_id,
      :forma_de_pago, :arte, :descripcion, :total_articulo,
      :estado_pedido, :estado,:cantidad_total,:precio_total,
      tiempos_de_entregas_attributes:[:pedido_id, :remision, :cantidad, :fecha_compromiso, :precio, :fecha_de_despacho, :cantidad_enviada, :precio_a_facturar, :cantidad_faltante, :anexo, :entrega_cumplida, :estado, :_destroy],
      despachos_attributes:[:pedido_id, :nombre, :nit, :telefono, :lugar_de_despacho, :direccion, :celular, :correo, :recibe, :observacion, :facturar, :entregar_factura, :estado, :_destroy],
      ordenes_de_produccion_attributes:[:pedido_id, :descripcion,  :codigo, :total, :cantidad, :fecha,:inventario,:estado, :_destroy])
    end




end
