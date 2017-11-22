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

  
  
end
