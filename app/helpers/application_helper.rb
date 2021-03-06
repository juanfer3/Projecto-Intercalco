module ApplicationHelper
  def nombre_usuario
     User.where("id = ?", User.current_user.email).first.name if User.where("id = ?", User.current_user.email).first
  end

  def paginar(n, modelo)
    if will_paginate
      ('<div class="pull-left">
        '+n+' '+modelo.count.to_s+'
        <br>
        '+(will_paginate modelo, renderer: BootstrapPagination::Rails, class: 'pagination-sm') +'
      </div>').html_safe
    else
      ('<div class="pull-left">
        '+n+' '+modelo.count.to_s+'
        <br>
      </div>').html_safe
    end
  end

  def btn_ver(obj)
    (link_to obj, class: 'btn btn-primary btn-sm', 'data-toggle' => 'tooltip',
    'title' => 'Ver Detalles',remote: true do
    '<i class="glyphicon glyphicon-eye-open"></i>'.html_safe end).html_safe
  end

  def link_to_add_remision(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: "add_remisiones " + args[:class], data: {id: id, fields: fields.gsub("\n", "")})
  end





  def number_to_currency_br(number)
    number_to_currency(number, :unit => "", :separator => ",", :delimiter => ".")
  end

  def number_to_currency_entero(number)
    number_to_currency(number, :unit => "",  :delimiter => ".")
  end
  def number_to_currency_moneda(number)
    number_to_currency(number, :unit => "$", :separator => ",", :delimiter => ".")
  end

  def number_to_currency_no_moneda(number)
    number_to_currency(number, :unit => "",  :separator => ",", :delimiter => ".")
  end

  def numero_beuty(number)
    #code
    number.to_s.reverse.scan(/(?:\d*\.)?\d{1,3}-?/).join('.').reverse
  end

  def is_number? string
      true if Float(string) rescue false
  end

end
