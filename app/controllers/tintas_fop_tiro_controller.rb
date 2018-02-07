class TintasFopTiroController < ApplicationController
  before_action :set_tinta_fop_tiro, only: [:show, :edit, :update, :destroy]

  # GET /tintas_fop_tiro
  # GET /tintas_fop_tiro.json
  def index
    @tintas_fop_tiro = TintaFopTiro.all
  end



  # GET /tintas_fop_tiro/1
  # GET /tintas_fop_tiro/1.json
  def show
  end

  # GET /tintas_fop_tiro/new
  def new
    @tinta_fop_tiro = TintaFopTiro.new
  end

  # GET /tintas_fop_tiro/1/edit
  def edit
  end

  # POST /tintas_fop_tiro
  # POST /tintas_fop_tiro.json
  def create
    @tinta_fop_tiro = TintaFopTiro.new(tinta_fop_tiro_params)

    respond_to do |format|
      if @tinta_fop_tiro.save
        @Tintas_tiro=[]

        @montaje= Montaje.find_by(id:@tinta_fop_tiro.montaje.id)

        @montaje.tintas_fop_tiro.each do |tintas_retiro|

            @busq2_tinta = Tinta.joins(:linea_de_color).find_by(descripcion: tintas_retiro.descripcion)
            puts "******************#{@busq2_tinta}**********************"
            if @busq2_tinta == nil
              puts "******************Esta Vacio**********************"
              @formula2_tintas = TintaFormulada.joins(:linea_de_color).find_by(descripcion: tintas_retiro.descripcion)

              @Tintas_tiro << @formula2_tintas

            else
              puts "******************Esta Vacio**********************"
              @Tintas_tiro << @busq2_tinta


            end

        end

        format.html { redirect_to @tinta_fop_tiro, notice: 'Tinta fop tiro was successfully created.' }
        format.json { render :show, status: :created, location: @tinta_fop_tiro }
        format.js
      else
        format.html { render :new }
        format.json { render json: @tinta_fop_tiro.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /tintas_fop_tiro/1
  # PATCH/PUT /tintas_fop_tiro/1.json
  def update
    respond_to do |format|
      if @tinta_fop_tiro.update(tinta_fop_tiro_params)
        format.html { redirect_to @tinta_fop_tiro, notice: 'Tinta fop tiro was successfully updated.' }
        format.json { render :show, status: :ok, location: @tinta_fop_tiro }
      else
        format.html { render :edit }
        format.json { render json: @tinta_fop_tiro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tintas_fop_tiro/1
  # DELETE /tintas_fop_tiro/1.json
  def destroy
    @tinta_fop_tiro.destroy
    respond_to do |format|
      format.html { redirect_to tintas_fop_tiro_url, notice: 'Tinta fop tiro was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tinta_fop_tiro
      @tinta_fop_tiro = TintaFopTiro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tinta_fop_tiro_params
      params.require(:tinta_fop_tiro).permit(:montaje_id, :tinta, :malla_id, :descripcion, :estado)
    end
end
