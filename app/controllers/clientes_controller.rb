class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
#Clientes Excel
  def vista_subir_excel
    @user_id= current_user.id
  end



  def buscar_nombre_cliente
    data = params["data"]
    puts"===============#{data}================".blue
    estado = true
    comercial= "Comercial"
    gerente_comercial = "Gerente Comercial"
    @clientes = Cliente.where("nombre ILIKE ? AND estado = ?", "%"+data+"%", estado).order('nombre')
    @comerciales = User.joins(:rol).where('roles.cargo = ? OR roles.cargo = ?', comercial, gerente_comercial)

    respond_to do |format|
        format.js
    end
  end

  def import_from_excel

    file = params[:file]
    begin
      errores_o_true = Cliente.subir_excel(file)

      respond_to do |format|
        if errores_o_true == true
          format.html { redirect_to clientes_path, notice: 'Clientes Importados' }
          format.json { render :show, status: :created, location: @cliente }
        else
          @errores = errores_o_true
          format.html { render 'vista_subir_excel'}
        end
    end
    rescue Exception => e
      flash[:notice] = "Tipo de archivo no valido"
      redirect_to clientes_path
    end
  end

#Contactos Excel
def contactos_subir_excel

end



#validarCreacionDeCliente
def ValidarClienteBusquedad
  #code
  data = params['data']
  data = data.to_s.upcase
  puts "******************ESTA ES LA DATA: #{data}**********************".red
  val_estado = true
  @clientes = []
  @clientes= Cliente.where("nombre  = ? AND estado = ?", data, val_estado).order('nombre') if data.present?

  @validar = false
  @validar = true if @clientes.empty?
  respond_to do |format|
    format.js
  end
end

def import_contactos_from_excel
  @cliente = Cliente.find(params[:id])

  my_user_id = current_user.id
  file = params[:file]
  begin
    errores_o_true = Cliente.subir_excel_contactos(file, my_user_id, @cliente.id)

    respond_to do |format|
      if errores_o_true == true
        format.html { redirect_to @cliente, notice: 'Contactos Importados' }
        format.json { render :show, status: :created, location: @cliente }
      else
        @errores = errores_o_true
        format.html { render 'vista_subir_excel'}
      end
  end
  rescue Exception => e
    flash[:notice] = "Tipo de archivo no valido"
    redirect_to clientes_path
  end
end

  # GET /clientes
  # GET /clientes.json
  def index
    if current_user.rol.cargo == "Administrador"
      @clientes = Cliente.all.paginate(page: params[:page], per_page: 20).order('nombre').distinct
      comercial= "Comercial"
      gerente_comercial = "Gerente Comercial"
      @comerciales = User.joins(:rol).where('roles.cargo = ? OR roles.cargo = ?', comercial, gerente_comercial)

    elsif current_user.rol.cargo == "Comercial"
      @clientes = Cliente.joins(:contactos, :user).paginate(page: params[:page], per_page: 20).where("contactos.user_id=#{current_user.id}").order('nombre').distinct
      comercial= "Comercial"
      gerente_comercial = "Gerente Comercial"
      @comerciales = User.joins(:rol).where('roles.cargo = ? OR roles.cargo = ?', comercial, gerente_comercial)

    elsif current_user.rol.cargo == "Producción"
      val_estado = true
      @clientes = Cliente.all.paginate(page: params[:page], per_page: 20).where("estado =?",val_estado).order('nombre').distinct
      comercial= "Comercial"
      gerente_comercial = "Gerente Comercial"
      @comerciales = User.joins(:rol).where('roles.cargo = ? OR roles.cargo = ?', comercial, gerente_comercial)

    end
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    puts "==============="+@cliente.id.to_s+"======================"

  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
    @cliente.contactos.build
    @cliente.nombres_facturaciones.build
    @cliente.lugares_despachos.build
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = current_user.clientes.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to clientes_url, notice: 'Cliente was successfully created.' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to clientes_url, notice: 'Cliente was successfully updated.' }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url, notice: 'Cliente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cliente_params
      params.require(:cliente).permit(:nombre, :nit, :direccion, :telefono, :correo, :user_id, :estado,
      contactos_attributes: [:id,:_destroy,:nombre_contacto, :telefono, :celular, :correo, :cliente_id, :user_id,:estado],
      lugares_despachos_attributes:[:id,:_destroy,:cliente_id, :nombre, :direccion, :telefono],
      nombres_facturaciones_attributes:[:id,:_destroy,:cliente_id, :nombre, :direccion, :telefono]
    )
    end
end
