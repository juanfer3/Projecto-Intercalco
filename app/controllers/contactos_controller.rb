class ContactosController < ApplicationController
  before_action :set_contacto, only: [:show, :edit, :update, :destroy]

  # GET /contactos
  # GET /contactos.json
  def index
    if current_user.rol.cargo == "Administrador"
      @contactos = Contacto.all.paginate(page: params[:page], per_page: 20)
    elsif current_user.rol.cargo == "Comercial"
      @contactos = Contacto.joins(:cliente, :user).paginate(page: params[:page], per_page: 20).where( "contactos.user_id=#{current_user.id}")
    elsif current_user.rol.cargo == "Gerente Comercial"
      @contactos = Contacto.all.paginate(page: params[:page], per_page: 20)
    end
  end

  # GET /contactos/1
  # GET /contactos/1.json
  def show
  end

  # GET /contactos/1.json
  def vista
    @contactos = Contacto.joins(:cliente).find(params[:id])
    render json: @contactos.to_json(:include => :cliente)
  end

  # GET /contactos/new
  def new
    @contacto = Contacto.new
  end

  # GET /contactos/1/edit
  def edit
  end

  # POST /contactos
  # POST /contactos.json
  def create
    @contacto = current_user.contactos.new(contacto_params)

    respond_to do |format|
      if @contacto.save
        format.html { redirect_to @contacto, notice: 'Contacto was successfully created.' }
        format.json { render :show, status: :created, location: @contacto }
      else
        format.html { render :new }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contactos/1
  # PATCH/PUT /contactos/1.json
  def update
    respond_to do |format|
      if @contacto.update(contacto_params)
        format.html { redirect_to @contacto, notice: 'Contacto was successfully updated.' }
        format.json { render :show, status: :ok, location: @contacto }
      else
        format.html { render :edit }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactos/1
  # DELETE /contactos/1.json
  def destroy
    @contacto.destroy
    respond_to do |format|
      format.html { redirect_to contactos_url, notice: 'Contacto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contacto
      @contacto = Contacto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contacto_params
      params.require(:contacto).permit(:nombre_contacto, :telefono, :celular, :correo, :cliente_id, :user_id,:estado)
    end
end
