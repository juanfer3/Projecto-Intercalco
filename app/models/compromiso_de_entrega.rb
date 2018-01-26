class CompromisoDeEntrega < ApplicationRecord
  belongs_to :orden_produccion

  after_update  :cerrar


  def cerrar()

    puts "****************************************Edicion A LA ORdes De PRoduccion "+self.orden_produccion_id.to_s+"***********************************+"
    @envios = CompromisoDeEntrega.where("orden_produccion_id='#{self.orden_produccion_id}'")
    @orden = OrdenProduccion.find_by(id: self.orden_produccion_id)
    if @envios == nil
        puts"*********************************************Busqueda Nula***********************************************"
    else
      cont=0
      tam_length = @envios.length
        @envios.each do  |envio|
          if envio.enviado== true
            cont = cont + 1

          end
        end
        if cont == tam_length
          puts "**************************SE puede Cerrar**************"
        @orden.update(entregado:true)


              puts "**************************Cambio exitoso  #{@orden.entregado}**************"

        else
          puts "**************************NO SE puede Cerrar**************"
          if @orden.entregado == true
            @orden.update(entregado:false)

          end
        end

    end

  end
end
