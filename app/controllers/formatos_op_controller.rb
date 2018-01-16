class FormatosOpController < ApplicationController
  before_action :set_formato_op, only: [:show, :edit, :update, :destroy]

  # GET /formatos_op
  # GET /formatos_op.json
  def index
    @formatos_op = FormatoOp.all
  end

  # GET /formatos_op/1
  # GET /formatos_op/1.json
  def show

  end

  def buscar_fop
    @formato_op = FormatoOp.joins(:user,:montaje).find(params[:id])
    render json: @formatos_op .to_json(:include => :montaje)
  end

  # GET /formatos_op/new
  def new
    @formato_op = FormatoOp.new
  end

  # GET /formatos_op/1/edit
  def edit
  end

  # POST /formatos_op
  # POST /formatos_op.json
  def create
    @formato_op = FormatoOp.new(formato_op_params)

    respond_to do |format|
      if @formato_op.save
        format.html { redirect_to @formato_op, notice: 'Formato op was successfully created.' }
        format.json { render :show, status: :created, location: @formato_op }
      else
        format.html { render :new }
        format.json { render json: @formato_op.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formatos_op/1
  # PATCH/PUT /formatos_op/1.json
  def update
    respond_to do |format|
      if @formato_op.update(formato_op_params)
        format.html { redirect_to @formato_op, notice: 'Formato op was successfully updated.' }
        format.json { render :show, status: :ok, location: @formato_op }
      else
        format.html { render :edit }
        format.json { render json: @formato_op.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formatos_op/1
  # DELETE /formatos_op/1.json
  def destroy
    @formato_op.destroy
    respond_to do |format|
      format.html { redirect_to formatos_op_url, notice: 'Formato op was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formato_op
      @formato_op = FormatoOp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def formato_op_params
      params.require(:formato_op).permit(:user_id, :maquina_id, :montaje_id, :pieza_a_decorar_id, :referencia_de_orden, :linea_de_color_id, :tipo_de_produccion, :material, :temperatura, :tamanos_total, :cavidad, :tipo_de_linea, :cantidad_hoja, :observacion, :linea_producto_id, :estado)
    end
end
