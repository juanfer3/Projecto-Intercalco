module TintasFopTiroHelper
  def link_to_add_tintas_tiro(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: "add_tintas_tiro " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end
end
