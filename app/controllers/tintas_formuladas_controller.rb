class TintasFormuladasController < ApplicationController
  before_action :set_tinta_formulada, only: [:show, :edit, :update, :destroy]

  # GET /tintas_formuladas
  # GET /tintas_formuladas.json
  def index
    @tintas_formuladas= TintaFormulada.all.paginate(page: params[:page], per_page: 20).order('codigo')
  end

  def crear_color
    #code
    @desarrollo_de_tinta = DesarrolloDeTinta.find(params[:id])
    @tinta_formulada = TintaFormulada.new(tinta_formulada_params)
    respond_to do |format|
      if @tinta_formulada.save

        format.js
      else
        format.js
      end
    end
  end

  def import_tintas_formuladas_from_excel
    file = params[:file]
    begin
      errores_o_true = TintaFormulada.subir_excel(file)

      respond_to do |format|
        if errores_o_true == true
          format.js { redirect_to tintas_formuladas_path, notice: 'Tintas_Bases Importados' }
          format.json { render :show, status: :created, location: @tinta }
        else
          @errores = errores_o_true
          format.js { render tintas_formuladas_path}
        end
    end
    rescue Exception => e
      flash[:notice] = "Tipo de archivo no valido"
      redirect_to tintas_formuladas_path
    end
  end

  # GET /tintas_formuladas/1
  # GET /tintas_formuladas/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /tintas_formuladas/new
  def new
    @tinta_formulada = TintaFormulada.new
    @tinta_formulada.formulas_tinta.build
    @tinta_formulada.transiciones.build
  end

  # GET /tintas_formuladas/1/edit
  def edit
  end

  # POST /tintas_formuladas
  # POST /tintas_formuladas.json
  def create
    @tinta_formulada = TintaFormulada.new(tinta_formulada_params)

    respond_to do |format|
      if @tinta_formulada.save
          if @tinta_formulada.transiciones == nil
            puts "**************************Vacio tinta**************"
          else
            puts "**************************LLeno tinta*************"
            @tinta_formulada.transiciones.each do |transicion|
              @montaje = Montaje.where("desarrollos_de_tintas.montaje_id=#{transicion.desarrollo_de_tinta.montaje.id}")
              if @montaje== nil
                puts "**************************Montaje Vacio**************"
              else
                puts "**************************Montaje LLeno*************"
                @eliminar_transicion = Transicion.find_by(id:transicion.id)
                @eliminar_transicion.destroy

                @tinta_solicitada = DesarrolloDeTinta.find_by(id:transicion.desarrollo_de_tinta.id)

                  if @tinta_solicitada.tiro == true
                    tinta_tiro = TintaFopTiro.new(montaje_id: @tinta_solicitada.montaje.id, malla_id: @tinta_solicitada.malla.id,descripcion: @tinta_formulada.descripcion)

                    if tinta_tiro.save
                      puts "**************************Tinta Tiro Creada**************"
                    end
                  end


                  if @tinta_solicitada.retiro == true
                    tinta_tiro = TintaFopRetiro.new(montaje_id: @tinta_solicitada.montaje.id, malla_id: @tinta_solicitada.malla.id,descripcion: @tinta_formulada.descripcion)

                    if tinta_tiro.save
                      puts "**************************Tinta Tiro Creada**************"
                    end
                  end
                  @tinta_solicitada.destroy
              end

            end
          end

        @montaje = Montaje.find_by(id: @tinta)
        format.html { redirect_to @tinta_formulada, notice: 'Tinta formulada was successfully created.' }
        format.json { render :show, status: :created, location: @tinta_formulada }
        format.js
      else
        format.html { render :new }
        format.json { render json: @tinta_formulada.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /tintas_formuladas/1
  # PATCH/PUT /tintas_formuladas/1.json
  def update
    respond_to do |format|
      if @tinta_formulada.update(tinta_formulada_params)
        format.html { redirect_to @tinta_formulada, notice: 'Tinta formulada was successfully updated.' }
        format.json { render :show, status: :ok, location: @tinta_formulada }
      else
        format.html { render :edit }
        format.json { render json: @tinta_formulada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tintas_formuladas/1
  # DELETE /tintas_formuladas/1.json
  def destroy
    @tinta_formulada.destroy
    respond_to do |format|
      format.html { redirect_to tintas_formuladas_url, notice: 'Tinta formulada was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tinta_formulada
      @tinta_formulada = TintaFormulada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tinta_formulada_params
      params.require(:tinta_formulada).permit(:linea_de_color_id, :malla_id, :codigo, :descripcion, :pantone, :cantidad_total, :estado,
      formulas_tinta_attributes:[:tinta_formulada_id, :tinta_id, :porcentaje, :estado],
      transiciones_attributes:[:desarrollo_de_tinta_id, :tinta_formulada_id])
    end
end
