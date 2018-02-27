module NombresFacturacionesHelper
  def link_to_add_nombre_facturacion(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: "add_nombre_facturacion" + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end
end
