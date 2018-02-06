class TintasFopRetiroController < ApplicationController
  before_action :set_tinta_fop_retiro, only: [:show, :edit, :update, :destroy]

  # GET /tintas_fop_retiro
  # GET /tintas_fop_retiro.json
  def index
    @tintas_fop_retiro = TintaFopRetiro.all
  end

  # GET /tintas_fop_retiro/1
  # GET /tintas_fop_retiro/1.json
  def show
  end

  # GET /tintas_fop_retiro/new
  def new
    @tinta_fop_retiro = TintaFopRetiro.new
  end

  # GET /tintas_fop_retiro/1/edit
  def edit
  end

  # POST /tintas_fop_retiro
  # POST /tintas_fop_retiro.json
  def create
    @tinta_fop_retiro = TintaFopRetiro.new(tinta_fop_retiro_params)

    respond_to do |format|
      if @tinta_fop_retiro.save
        @Tintas_retiro=[]


        @montaje= Montaje.find_by(id:@tinta_fop_retiro.montaje.id)

        @montaje.tintas_fop_retiro.each do |tintas_retiro|

            @busq2_tinta = Tinta.joins(:linea_de_color).find_by(descripcion: tintas_retiro.descripcion)
            puts "******************#{@busq2_tinta}**********************"
            if @busq2_tinta == nil
              puts "******************Esta Vacio**********************"
              @formula2_tintas = TintaFormulada.joins(:linea_de_color).find_by(descripcion: tintas_retiro.descripcion)

              @Tintas_retiro << @formula2_tintas

            else
              puts "******************Esta Vacio**********************"
              @Tintas_retiro << @busq2_tinta


            end

        end


        format.html { redirect_to @tinta_fop_retiro, notice: 'Tinta fop retiro was successfully created.' }
        format.json { render :show, status: :created, location: @tinta_fop_retiro }
        format.js
      else
        format.html { render :new }
        format.json { render json: @tinta_fop_retiro.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /tintas_fop_retiro/1
  # PATCH/PUT /tintas_fop_retiro/1.json
  def update
    respond_to do |format|
      if @tinta_fop_retiro.update(tinta_fop_retiro_params)
        format.html { redirect_to @tinta_fop_retiro, notice: 'Tinta fop retiro was successfully updated.' }
        format.json { render :show, status: :ok, location: @tinta_fop_retiro }
      else
        format.html { render :edit }
        format.json { render json: @tinta_fop_retiro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tintas_fop_retiro/1
  # DELETE /tintas_fop_retiro/1.json
  def destroy
    @tinta_fop_retiro.destroy
    respond_to do |format|
      format.html { redirect_to tintas_fop_retiro_url, notice: 'Tinta fop retiro was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tinta_fop_retiro
      @tinta_fop_retiro = TintaFopRetiro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tinta_fop_retiro_params
      params.require(:tinta_fop_retiro).permit(:montaje_id, :tinta, :malla_id, :descripcion, :estado)
    end
end
