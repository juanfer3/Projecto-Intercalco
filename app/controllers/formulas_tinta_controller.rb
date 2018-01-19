class FormulasTintaController < ApplicationController
  before_action :set_formula_tinta, only: [:show, :edit, :update, :destroy]

  # GET /formulas_tinta
  # GET /formulas_tinta.json
  def index
    @formulas_tinta = FormulaTinta.all
  end

  def import_formulaTintas_from_excel
    file = params[:file]
    begin
      errores_o_true = FormulaTinta.subir_excel(file)

      respond_to do |format|
        if errores_o_true == true
          format.html { redirect_to formulas_tinta_path, notice: 'Tintas_Bases Importados' }
          format.json { render :show, status: :created, location: @formula_tinta }
        else
          @errores = errores_o_true
          format.html { render formulas_tinta_path}
        end
    end
    rescue Exception => e
      flash[:notice] = "Tipo de archivo no valido"
      redirect_to formulas_tinta_path
    end
  end

  # GET /formulas_tinta/1
  # GET /formulas_tinta/1.json
  def show
  end

  # GET /formulas_tinta/new
  def new
    @formula_tinta = FormulaTinta.new
  end

  # GET /formulas_tinta/1/edit
  def edit
  end

  # POST /formulas_tinta
  # POST /formulas_tinta.json
  def create
    @formula_tinta = FormulaTinta.new(formula_tinta_params)

    respond_to do |format|
      if @formula_tinta.save
        format.html { redirect_to @formula_tinta, notice: 'Formula tinta was successfully created.' }
        format.json { render :show, status: :created, location: @formula_tinta }
      else
        format.html { render :new }
        format.json { render json: @formula_tinta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formulas_tinta/1
  # PATCH/PUT /formulas_tinta/1.json
  def update
    respond_to do |format|
      if @formula_tinta.update(formula_tinta_params)
        format.html { redirect_to @formula_tinta, notice: 'Formula tinta was successfully updated.' }
        format.json { render :show, status: :ok, location: @formula_tinta }
      else
        format.html { render :edit }
        format.json { render json: @formula_tinta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formulas_tinta/1
  # DELETE /formulas_tinta/1.json
  def destroy
    @formula_tinta.destroy
    respond_to do |format|
      format.html { redirect_to formulas_tinta_url, notice: 'Formula tinta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formula_tinta
      @formula_tinta = FormulaTinta.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def formula_tinta_params
      params.require(:formula_tinta).permit(:tinta_formulada_id, :tinta_id, :porcentaje, :estado)
    end
end
