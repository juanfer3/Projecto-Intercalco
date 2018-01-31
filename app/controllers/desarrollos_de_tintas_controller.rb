class DesarrollosDeTintasController < ApplicationController
  before_action :set_desarrollo_de_tinta, only: [:show, :edit, :update, :destroy]

  # GET /desarrollos_de_tintas
  # GET /desarrollos_de_tintas.json
  def index
    @desarrollos_de_tintas = DesarrolloDeTinta.all
  end

  # GET /desarrollos_de_tintas/1
  # GET /desarrollos_de_tintas/1.json
  def show
  end

  # GET /desarrollos_de_tintas/new
  def new
    @desarrollo_de_tinta = DesarrolloDeTinta.new
  end

  # GET /desarrollos_de_tintas/1/edit
  def edit
  end

  # POST /desarrollos_de_tintas
  # POST /desarrollos_de_tintas.json
  def create
    @desarrollo_de_tinta = DesarrolloDeTinta.new(desarrollo_de_tinta_params)

    respond_to do |format|
      if @desarrollo_de_tinta.save
        format.html { redirect_to @desarrollo_de_tinta, notice: 'Desarrollo de tinta was successfully created.' }
        format.json { render :show, status: :created, location: @desarrollo_de_tinta }
      else
        format.html { render :new }
        format.json { render json: @desarrollo_de_tinta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /desarrollos_de_tintas/1
  # PATCH/PUT /desarrollos_de_tintas/1.json
  def update
    respond_to do |format|
      if @desarrollo_de_tinta.update(desarrollo_de_tinta_params)
        format.html { redirect_to @desarrollo_de_tinta, notice: 'Desarrollo de tinta was successfully updated.' }
        format.json { render :show, status: :ok, location: @desarrollo_de_tinta }
      else
        format.html { render :edit }
        format.json { render json: @desarrollo_de_tinta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /desarrollos_de_tintas/1
  # DELETE /desarrollos_de_tintas/1.json
  def destroy

    @desarrollo_de_tinta.destroy
    @montajes = Montaje.find_by(id: @desarrollo_de_tinta.montaje.id)

      if @montajes.desarrollos_de_tintas.any?
        puts "******************Existe**********************"
      else
        puts "*******************No Existe*********************"
        @montajes.update(tinta_nueva:false)
      end




      
    respond_to do |format|
      format.html { redirect_to desarrollos_de_tintas_url, notice: 'Desarrollo de tinta was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_desarrollo_de_tinta
      @desarrollo_de_tinta = DesarrolloDeTinta.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def desarrollo_de_tinta_params
      params.require(:desarrollo_de_tinta).permit(:montaje_id, :linea_de_color_id, :malla_id, :descripción, :cantidad, :estado, :tiro, :retiro)
    end
end
