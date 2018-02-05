module CompromisosDeEntregaHelper
  def link_to_add_compromisos(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: "add_compromisos " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_remove_compromisos(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_compromisos(this)")
  end


  def link_to_function(name, *args, &block)
     html_options = args.extract_options!.symbolize_keys

     function = block_given? ? update_page(&block) : args[0] || ''
     onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
     href = html_options[:href] || '#'

     content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
  end

end
