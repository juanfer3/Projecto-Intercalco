class HabilitarRolMaquinasController < ApplicationController
  before_action :set_habilitar_rol_maquina, only: [:show, :edit, :update, :destroy]

  # GET /habilitar_rol_maquinas
  # GET /habilitar_rol_maquinas.json
  def index
    @habilitar_rol_maquinas = HabilitarRolMaquina.all
  end

  # GET /habilitar_rol_maquinas/1
  # GET /habilitar_rol_maquinas/1.json
  def show
  end

  # GET /habilitar_rol_maquinas/new
  def new
    @habilitar_rol_maquina = HabilitarRolMaquina.new
  end

  # GET /habilitar_rol_maquinas/1/edit
  def edit
  end

  # POST /habilitar_rol_maquinas
  # POST /habilitar_rol_maquinas.json
  def create
    @habilitar_rol_maquina = HabilitarRolMaquina.new(habilitar_rol_maquina_params)

    respond_to do |format|
      if @habilitar_rol_maquina.save
        format.html { redirect_to @habilitar_rol_maquina, notice: 'Habilitar rol maquina was successfully created.' }
        format.json { render :show, status: :created, location: @habilitar_rol_maquina }
      else
        format.html { render :new }
        format.json { render json: @habilitar_rol_maquina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /habilitar_rol_maquinas/1
  # PATCH/PUT /habilitar_rol_maquinas/1.json
  def update
    respond_to do |format|
      if @habilitar_rol_maquina.update(habilitar_rol_maquina_params)
        format.html { redirect_to @habilitar_rol_maquina, notice: 'Habilitar rol maquina was successfully updated.' }
        format.json { render :show, status: :ok, location: @habilitar_rol_maquina }
      else
        format.html { render :edit }
        format.json { render json: @habilitar_rol_maquina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habilitar_rol_maquinas/1
  # DELETE /habilitar_rol_maquinas/1.json
  def destroy
    @habilitar_rol_maquina.destroy
    respond_to do |format|
      format.html { redirect_to habilitar_rol_maquinas_url, notice: 'Habilitar rol maquina was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_habilitar_rol_maquina
      @habilitar_rol_maquina = HabilitarRolMaquina.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def habilitar_rol_maquina_params
      params.require(:habilitar_rol_maquina).permit(:maquina_id, :rol_id)
    end
end
