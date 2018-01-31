class TransicionesController < ApplicationController
  before_action :set_transicion, only: [:show, :edit, :update, :destroy]

  # GET /transiciones
  # GET /transiciones.json
  def index
    @transiciones = Transicion.all
  end

  # GET /transiciones/1
  # GET /transiciones/1.json
  def show
  end

  # GET /transiciones/new
  def new
    @transicion = Transicion.new
  end

  # GET /transiciones/1/edit
  def edit
  end

  # POST /transiciones
  # POST /transiciones.json
  def create
    @transicion = Transicion.new(transicion_params)

    respond_to do |format|
      if @transicion.save
        format.html { redirect_to @transicion, notice: 'Transicion was successfully created.' }
        format.json { render :show, status: :created, location: @transicion }
      else
        format.html { render :new }
        format.json { render json: @transicion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transiciones/1
  # PATCH/PUT /transiciones/1.json
  def update
    respond_to do |format|
      if @transicion.update(transicion_params)
        format.html { redirect_to @transicion, notice: 'Transicion was successfully updated.' }
        format.json { render :show, status: :ok, location: @transicion }
      else
        format.html { render :edit }
        format.json { render json: @transicion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transiciones/1
  # DELETE /transiciones/1.json
  def destroy
    @transicion.destroy
    respond_to do |format|
      format.html { redirect_to transiciones_url, notice: 'Transicion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transicion
      @transicion = Transicion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transicion_params
      params.require(:transicion).permit(:desarrollo_de_tinta_id, :tinta_formulada_id, :orden_produccion_id)
    end
end
