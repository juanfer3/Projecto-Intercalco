class OrdenProduccion < ApplicationRecord
  belongs_to :montaje

  has_many :compromisos_de_entrega, inverse_of: :orden_produccion, dependent: :destroy
  accepts_nested_attributes_for :compromisos_de_entrega, reject_if: :all_blank, allow_destroy: true

  has_many :formulas_tinta, inverse_of: :tinta_formulada, dependent: :destroy
  accepts_nested_attributes_for :formulas_tinta, reject_if: :all_blank, allow_destroy: true

  has_many :transiciones, inverse_of: :tinta_formulada, dependent: :destroy
  accepts_nested_attributes_for :transiciones, reject_if: :all_blank, allow_destroy: true

  def self.subir_excel(file)
    @errores = []

    file_ext = File.extname(file.original_filename)
    raise "Unknown file type: #{file.original_filename}" unless [".xls", ".xlsx", ".csv"].include?(file_ext)

    if file_ext == ".xlsx"
      spreadsheet = Roo::Excelx.new(file.path)
    elsif file_ext == ".xls"
      spreadsheet = Roo::Excel.new(file.path)
    elsif file_ext == ".csv"
      spreadsheet = Roo::CSV.new(file.path)
    end

    header = spreadsheet.row(1)

    (2..spreadsheet.last_row).each do |i|


      vendedor = spreadsheet.row(i)[2]
      @vendedor= User.find_by(nombre: vendedor)

      if @vendedor != nil
        puts "****************El Vendedor Existe Star************************"

        numero_orden = spreadsheet.row(i)[0]
        puts "****************Numer de Orden : #{numero_orden}************************"


            if numero_orden != ""

                          puts "****************la Orden no esta vacia***********************"
                          @ordenes = OrdenProduccion.find_by(numero_de_orden: numero_orden)
                          if @ordenes == nil
                            puts "****************la orden Existe #{numero_orden}***********************"

                          fecha_de_orden = spreadsheet.row(i)[4]
                          puts "**************Fecha de Orden: #{fecha_de_orden}**************************"

                          descripcion = spreadsheet.row(i)[7]
                          @bus_montaje= Montaje.find_by(nombre:descripcion)
                          if @bus_montaje == nil


                                  puts "*********** El montaje NO existe*****************************"
                                  cliente =  spreadsheet.row(i)[6]
                                  @bus_cliente= Cliente.find_by(nombre: cliente)


                                        if @bus_cliente == nil
                                                puts "***********El cliente NO existe*****************************"
                                                clienteNuevo=Cliente.new(nombre:cliente,user_id: @vendedor.id)

                                                if clienteNuevo.save
                                                  puts "***********El Cliente a sido Almacenado*****************************"
                                                  @cliente_id = clienteNuevo.id
                                                end
                                        else
                                                puts "***********El Cliente -SI- Existe*****************************"
                                                  @cliente_id = @bus_cliente.id
                                        end

                                        montajeNuevo = Montaje.new(  nombre: spreadsheet.row(i)[7], cliente_id: @cliente_id, user_id: @vendedor.id)

                                        if montajeNuevo.save
                                                puts "***********El Montaje a sido alamcenado*****************************"
                                                @montaje_id = montajeNuevo.id
                                        end

                                        pieza_a_decorar =  spreadsheet.row(i)[20]
                                        if pieza_a_decorar != ""
                                              @bus_pieza= PiezaADecorar.find_by(nombre: pieza_a_decorar)
                                              puts "**************Busqueda De la Pieza**************************"


                                                        if @bus_pieza== nil
                                                          puts "**************La pieza es nula**************************"
                                                          piezaNueva = PiezaADecorar.new(nombre:pieza_a_decorar)
                                                          if piezaNueva.save
                                                              puts "**************La pieza a sido Creada**************************"
                                                              @pieza_id=piezaNueva.id
                                                          end
                                                        else
                                                          puts "**************La pieza Existe**************************"
                                                            @pieza_id=@bus_pieza.id
                                                        end
                                        else

                                                puts "**************La El campo Pieza esta vacio**************************"
                                                busqueda="Por Definir"
                                                @bus_pieza= PiezaADecorar.find_by(nombre: busqueda)
                                                puts "**************Busqueda De la Pieza**************************"


                                                          if @bus_pieza== nil
                                                              piezaNueva = PiezaADecorar.new(nombre: busqueda)
                                                              if piezaNueva.save
                                                                  puts "**************La pieza a sido Creada y se Por Definir**************************"
                                                                  @pieza_id=piezaNueva.id
                                                              end
                                                          else
                                                              @pieza_id=@bus_pieza.id
                                                          end
                                        end




                                        maquina =  spreadsheet.row(i)[18]
                                        if maquina != ""
                                              @bus_maquina= Maquina.find_by(nombre: maquina)
                                              puts "**************Busqueda De la maquina**************************"


                                                        if @bus_maquina== nil
                                                          puts "**************La maquina es nula**************************"
                                                          maquinaNueva = Maquina.new(nombre: maquina)
                                                          if maquinaNueva.save
                                                              puts "**************La maquina a sido Creada**************************"
                                                              @maquina_id=maquinaNueva.id
                                                          end
                                                        else
                                                          puts "**************La maquina Existe**************************"
                                                            @maquina_id=@bus_maquina.id
                                                        end
                                        else
                                                puts "**************La El campo Pieza esta vacio**************************"
                                                busqueda="Por Definir"
                                                @bus_maquina= Maquina.find_by(nombre: busqueda)
                                                puts "**************Busqueda De la maquina nulas**************************"

                                                          busqueda="Por Definir"
                                                          if @bus_maquina== nil
                                                              maquinaNueva = Maquina.new(nombre: busqueda)
                                                              if maquinaNueva.save
                                                                  puts "**************La maquina a sido Creada y se Por Definir**************************"
                                                                  @maquina_id=maquinaNueva.id
                                                              end
                                                          else
                                                              @maquina_id=@bus_maquina.id
                                                          end
                                        end



                                        linea_color =  spreadsheet.row(i)[16]
                                        if linea_color != ""
                                              @bus_linea_color= LineaDeColor.find_by(nombre: linea_color)
                                              puts "**************Busqueda De la linea_color**************************"


                                                        if @bus_linea_color== nil
                                                          puts "**************La linea_color es nula**************************"
                                                          linea_colorNueva = LineaDeColor.new(nombre: linea_color)
                                                          if linea_colorNueva.save
                                                              puts "**************La linea_color a sido Creada**************************"
                                                              @linea_color_id=linea_colorNueva.id
                                                          end
                                                        else
                                                          puts "**************La linea_color Existe**************************"
                                                            @linea_color_id=@bus_linea_color.id
                                                        end
                                        else
                                                puts "**************La El campo Pieza esta vacio**************************"
                                                busqueda="Por Definir"
                                                @bus_linea_color= LineaDeColor.find_by(nombre: busqueda)
                                                puts "**************Busqueda De la linea_color nulas**************************"

                                                          busqueda="Por Definir"
                                                          if @bus_linea_color== nil
                                                              linea_colorNueva = LineaDeColor.new(nombre: busqueda)
                                                              if linea_colorNueva.save
                                                                  puts "**************La linea_color a sido Creada y se Por Definir**************************"
                                                                  @linea_color_id=linea_colorNueva.id
                                                              end
                                                          else
                                                              @linea_color_id=@bus_linea_color.id
                                                          end
                                        end





                                        linea_producto =  spreadsheet.row(i)[3]
                                        if linea_producto != ""
                                              @bus_linea_producto= LineaProducto.find_by(nombre: linea_producto)
                                              puts "**************Busqueda De la linea_producto**************************"


                                                        if @bus_linea_producto== nil
                                                          puts "**************La linea_producto es nula**************************"
                                                          linea_productoNueva = LineaProducto.new(nombre: linea_producto)
                                                          if linea_productoNueva.save
                                                              puts "**************La linea_producto a sido Creada**************************"
                                                              @linea_producto_id=linea_productoNueva.id
                                                          end
                                                        else
                                                          puts "**************La linea_producto Existe**************************"
                                                            @linea_producto_id=@bus_linea_producto.id
                                                        end
                                        else
                                                puts "**************La El campo Pieza esta vacio**************************"
                                                busqueda="Por Definir"
                                                @bus_linea_producto= LineaProducto.find_by(nombre: busqueda)
                                                puts "**************Busqueda De la linea_producto nulas**************************"

                                                          busqueda="Por Definir"
                                                          if @bus_linea_producto== nil
                                                              linea_productoNueva = LineaProducto.new(nombre: busqueda)
                                                              if linea_productoNueva.save
                                                                  puts "**************La linea_producto a sido Creada y se Por Definir**************************"
                                                                  @linea_producto_id=linea_productoNueva.id
                                                              end
                                                          else
                                                              @linea_producto_id=@bus_linea_producto.id
                                                          end
                                        end








                                        formato_op = FormatoOp.new(montaje_id: @montaje_id, pieza_a_decorar_id: @pieza_id, maquina_id: @maquina_id, linea_de_color_id: @linea_color_id, linea_producto_id:@linea_producto_id, material:spreadsheet.row(i)[15])
                                        if formato_op.save
                                          puts "***************Formato Guardado*************************"
                                        end




                                        fecha_de_orden = spreadsheet.row(i)[4]
                                        puts "***************fecha a parsear #{fecha_de_orden}*************************"
                                        fecha=fecha_de_orden.to_date
                                        puts "****************Fecha Parseada #{fecha}************************"

                                        ordenNueva=OrdenProduccion.new(montaje_id:@montaje_id, numero_de_orden:numero_orden, fecha:fecha)
                                        if ordenNueva.save
                                          puts "*******************Orden Almacenada*********************"
                                        else
                                          puts "*******************Orden Fallida*********************"
                                        end

                          else
                                        puts "***********el montaje si existe y el id: #{@bus_montaje}*****************************"



                                        @montaje_op_id = @bus_montaje.id
                                        fecha_de_orden = spreadsheet.row(i)[4]
                                        puts "***************fecha a parsear #{fecha_de_orden}*************************"
                                        fecha=fecha_de_orden.to_date
                                        puts "****************Fecha Parseada #{fecha}************************"

                                        ordenNueva=OrdenProduccion.new(montaje_id:@bus_montaje.id, numero_de_orden:numero_orden , fecha:fecha)
                                        if ordenNueva.save
                                          puts "*******************Orden Almacenada*********************"
                                        else
                                          puts "*******************Orden Fallida*********************"
                                        end

                          end




                          end


            end




      end




    end

    if @errores != []
      return @errores
    else
      return true
    end
  end


end
