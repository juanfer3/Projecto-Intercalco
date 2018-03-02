class LineasProductosController < ApplicationController
  before_action :set_linea_producto, only: [:show, :edit, :update, :destroy]

  # GET /lineas_productos
  # GET /lineas_productos.json
  def index
    @lineas_productos = LineaProducto.all.order("nombre")
  end

  # GET /lineas_productos/1
  # GET /lineas_productos/1.json
  def show
  end

  # GET /lineas_productos/new
  def new
    @linea_producto = LineaProducto.new
  end

  # GET /lineas_productos/1/edit
  def edit
  end

  # POST /lineas_productos
  # POST /lineas_productos.json
  def create
    @linea_producto = LineaProducto.new(linea_producto_params)

    respond_to do |format|
      if @linea_producto.save
        format.html { redirect_to lineas_productos_path, notice: 'Línea de producto creada.' }
        format.json { render :show, status: :created, location: @linea_producto }
      else
        format.html { render :new }
        format.json { render json: @linea_producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lineas_productos/1
  # PATCH/PUT /lineas_productos/1.json
  def update
    respond_to do |format|
      if @linea_producto.update(linea_producto_params)
        format.html { redirect_to lineas_productos_path, notice: 'Línea de producto editada.' }
        format.json { render :show, status: :ok, location: @linea_producto }
      else
        format.html { render :edit }
        format.json { render json: @linea_producto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lineas_productos/1
  # DELETE /lineas_productos/1.json
  def destroy
    @linea_producto.destroy
    respond_to do |format|
      format.html { redirect_to lineas_productos_url, notice: 'Registro eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linea_producto
      @linea_producto = LineaProducto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def linea_producto_params
      params.require(:linea_producto).permit(:nombre, :descripcion, :estado)
    end
end
