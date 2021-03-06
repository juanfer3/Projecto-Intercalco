class LineaDeColoresController < ApplicationController
  before_action :set_linea_de_color, only: [:show, :edit, :update, :destroy]

  # GET /linea_de_colores
  # GET /linea_de_colores.json
  def index
    @linea_de_colores = LineaDeColor.all.order("nombre")
  end

  # GET /linea_de_colores/1
  # GET /linea_de_colores/1.json
  def show
  end

  # GET /linea_de_colores/new
  def new
    @linea_de_color = LineaDeColor.new
  end

  # GET /linea_de_colores/1/edit
  def edit
  end

  # POST /linea_de_colores
  # POST /linea_de_colores.json
  def create
    @linea_de_color = LineaDeColor.new(linea_de_color_params)

    respond_to do |format|
      if @linea_de_color.save
        format.html { redirect_to lineas_de_colores_url, notice: 'Registro creado.' }
        format.json { render :show, status: :created, location: @linea_de_color }
      else
        format.html { render :new }
        format.json { render json: @linea_de_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /linea_de_colores/1
  # PATCH/PUT /linea_de_colores/1.json
  def update
    respond_to do |format|
      if @linea_de_color.update(linea_de_color_params)
        format.html { redirect_to lineas_de_colores_path, notice: 'Registro Editado.' }
        format.json { render :show, status: :ok, location: @linea_de_color }
      else
        format.html { render :edit }
        format.json { render json: @linea_de_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /linea_de_colores/1
  # DELETE /linea_de_colores/1.json
  def destroy
    @linea_de_color.destroy
    respond_to do |format|
      format.html { redirect_to lineas_de_colores_url, notice: 'Registro eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linea_de_color
      @linea_de_color = LineaDeColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def linea_de_color_params
      params.require(:linea_de_color).permit(:nombre, :descripcion, :estado)
    end
end
