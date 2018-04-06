class VariablesEstandarController < ApplicationController
  before_action :set_variable_estandar, only: [:show, :edit, :update, :destroy]

  # GET /variables_estandar
  # GET /variables_estandar.json
  def index
    @variables_estandar = VariableEstandar.all
  end

  # GET /variables_estandar/1
  # GET /variables_estandar/1.json
  def show
  end

  # GET /variables_estandar/new
  def new
    @variable_estandar = VariableEstandar.new
  end

  # GET /variables_estandar/1/edit
  def edit
  end

  # POST /variables_estandar
  # POST /variables_estandar.json
  def create
    @variable_estandar = VariableEstandar.new(variable_estandar_params)

    respond_to do |format|
      if @variable_estandar.save
        format.html { redirect_to @variable_estandar, notice: 'Variable estandar was successfully created.' }
        format.json { render :show, status: :created, location: @variable_estandar }
      else
        format.html { render :new }
        format.json { render json: @variable_estandar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variables_estandar/1
  # PATCH/PUT /variables_estandar/1.json
  def update
    respond_to do |format|
      if @variable_estandar.update(variable_estandar_params)
        format.html { redirect_to @variable_estandar, notice: 'Variable estandar was successfully updated.' }
        format.json { render :show, status: :ok, location: @variable_estandar }
      else
        format.html { render :edit }
        format.json { render json: @variable_estandar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variables_estandar/1
  # DELETE /variables_estandar/1.json
  def destroy
    @variable_estandar.destroy
    respond_to do |format|
      format.html { redirect_to variables_estandar_url, notice: 'Variable estandar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variable_estandar
      @variable_estandar = VariableEstandar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variable_estandar_params
      params.require(:variable_estandar).permit(:tiempo_de_montaje, :tiempo_de_desmontaje)
    end
end
