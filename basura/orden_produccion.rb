class OrdenProduccion < ApplicationRecord
  belongs_to :formato_op
  belongs_to :mes

  has_many :compromisos_de_entrega, inverse_of: :orden_produccion, dependent: :destroy
  accepts_nested_attributes_for :compromisos_de_entrega, reject_if: :all_blank, allow_destroy: true




  if direccion_nueva.present?
    puts "*********************Facturar a: #{direccion_nueva}*******************"
    buscar_facturar = LugarDespacho.find_by(direccion: direccion_nueva, cliente_id:tomar_cliente)

    if buscar_facturar == nil
      nombres_facturacion = LugarDespacho.create(cliente_id: tomar_cliente, direccion: direccion_nueva)
      if nombres_facturacion.save
        puts "****************Registro Guardado************************"
        self.lugar_despacho_id = nombres_facturacion.id
      end
    else
      self.lugar_despacho_id = buscar_facturar.id
    end

  end

  if facturar_a_nuevo.present?
    puts "********************Despachar a: #{facturar_a_nuevo}********************"
    buscar_despacho = NombreFacturacion.find_by(nombre: facturar_a_nuevo,  cliente_id:tomar_cliente)

    if buscar_despacho == nil
      direccion_despacho = NombreFacturacion.create(cliente_id: tomar_cliente, nombre: facturar_a_nuevo)
      if direccion_despacho.save
        puts "****************Registro Guardado************************"
        self.lugar_despacho_id = direccion_despacho.id
      end
    else
      self.lugar_despacho_id = buscar_despacho.id
    end

  end

end
