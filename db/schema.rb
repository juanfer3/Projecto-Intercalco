# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180115213918) do

  create_table "clientes", force: :cascade do |t|
    t.string "nombre"
    t.string "nit"
    t.string "direccion"
    t.string "telefono"
    t.string "correo"
    t.integer "user_id"
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clientes_on_user_id"
  end

  create_table "contactos", force: :cascade do |t|
    t.string "nombre_contacto"
    t.string "telefono"
    t.string "celular"
    t.string "correo"
    t.integer "cliente_id"
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["cliente_id"], name: "index_contactos_on_cliente_id"
    t.index ["user_id"], name: "index_contactos_on_user_id"
  end

  create_table "despachos", force: :cascade do |t|
    t.integer "pedido_id"
    t.string "nombre"
    t.string "nit"
    t.string "telefono"
    t.string "lugar_de_despacho"
    t.string "direccion"
    t.string "celular"
    t.string "correo"
    t.string "recibe"
    t.string "observacion"
    t.string "facturar"
    t.string "entregar_factura"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pedido_id"], name: "index_despachos_on_pedido_id"
  end

  create_table "facturas_despacho", force: :cascade do |t|
    t.integer "tiempos_de_entrega_id"
    t.string "numero_de_factura"
    t.float "total_facturado"
    t.float "iva"
    t.float "descuento"
    t.boolean "cancelada"
    t.float "cantidad_faltante"
    t.float "total_enviado"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tiempos_de_entrega_id"], name: "index_facturas_despacho_on_tiempos_de_entrega_id"
  end

  create_table "lineas_de_colores", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lineas_de_impresiones", force: :cascade do |t|
    t.string "tipo_de_linea"
    t.string "descripcion"
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lineas_productos", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maquinas", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "montajes", force: :cascade do |t|
    t.integer "cliente_id"
    t.string "nombre"
    t.string "tamano"
    t.string "dimension"
    t.float "dimension_1"
    t.float "dimension_2"
    t.string "codigo"
    t.string "numero_de_montaje"
    t.string "tipo_de_unidad"
    t.float "cantidad_total"
    t.string "observacion"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "modo_de_empaque"
    t.date "fecha_de_creacion"
    t.index ["cliente_id"], name: "index_montajes_on_cliente_id"
  end

  create_table "ordenes_de_produccion", force: :cascade do |t|
    t.integer "pedido_id"
    t.string "numero_de_orden", default: ""
    t.string "descripcion", default: ""
    t.date "fecha_final"
    t.float "total", default: 0.0
    t.string "codigo", default: ""
    t.float "cantidad", default: 0.0
    t.date "fecha"
    t.string "inventario", default: ""
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pedido_id"], name: "index_ordenes_de_produccion_on_pedido_id"
  end

  create_table "pedidos", force: :cascade do |t|
    t.integer "contacto_id"
    t.string "producto", default: ""
    t.string "tipo_de_trabajo", default: ""
    t.string "condicion_de_pedido", default: ""
    t.date "fecha_entrega"
    t.date "fecha_de_pedido"
    t.string "numero_cotizacion", default: "N/A"
    t.string "numero_de_pedido", default: ""
    t.integer "linea_de_impresion_id"
    t.string "forma_de_pago", default: ""
    t.string "arte", default: ""
    t.string "descripcion", default: ""
    t.string "estado_pedido", default: "Pedido"
    t.string "total_articulo", default: ""
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.float "cantidad_total"
    t.float "precio_total"
    t.boolean "pantalla", default: false
    t.boolean "color", default: false
    t.boolean "corte_material", default: false
    t.boolean "impresion", default: false
    t.boolean "troquel", default: false
    t.boolean "acabado", default: false
    t.boolean "habilitar_impresion", default: true
    t.boolean "habilitar_acabado", default: true
    t.index ["contacto_id"], name: "index_pedidos_on_contacto_id"
    t.index ["linea_de_impresion_id"], name: "index_pedidos_on_linea_de_impresion_id"
    t.index ["user_id"], name: "index_pedidos_on_user_id"
  end

  create_table "piezas", force: :cascade do |t|
    t.integer "montaje_id"
    t.string "nombre"
    t.string "tamano"
    t.string "tipo_de_unidad"
    t.string "dimension"
    t.string "descripcion"
    t.float "cantidad"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "codigo"
    t.date "fecha_de_creacion"
    t.index ["montaje_id"], name: "index_piezas_on_montaje_id"
  end

  create_table "piezas_a_decorar", force: :cascade do |t|
    t.string "nombre"
    t.string "descripccion"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "producciones_ordenes", force: :cascade do |t|
    t.integer "cliente_id"
    t.integer "user_id"
    t.integer "maquina_id"
    t.integer "montaje_id"
    t.integer "pieza_a_decorar_id"
    t.string "numero_de_orden"
    t.string "mes"
    t.float "cantidad_programada"
    t.float "precio_unitario"
    t.float "valor_total"
    t.string "tipo_de_produccion"
    t.float "tamanos_total"
    t.float "cavidad"
    t.string "tipo_de_linea"
    t.date "fecha"
    t.date "fecha_compromiso"
    t.float "cantidad_hoja"
    t.boolean "tiro"
    t.boolean "retiro"
    t.string "observacion"
    t.boolean "pantalla"
    t.boolean "color"
    t.boolean "corte_material"
    t.boolean "impresion"
    t.boolean "troquel"
    t.boolean "acabado"
    t.boolean "habilitar_impresion"
    t.boolean "habilitar_acabado"
    t.string "estado_de_orde"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_producciones_ordenes_on_cliente_id"
    t.index ["maquina_id"], name: "index_producciones_ordenes_on_maquina_id"
    t.index ["montaje_id"], name: "index_producciones_ordenes_on_montaje_id"
    t.index ["pieza_a_decorar_id"], name: "index_producciones_ordenes_on_pieza_a_decorar_id"
    t.index ["user_id"], name: "index_producciones_ordenes_on_user_id"
  end

  create_table "remisiones", force: :cascade do |t|
    t.integer "factura_despacho_id"
    t.string "numero_de_remision"
    t.date "fecha_de_despacho"
    t.float "cantidad_enviada"
    t.float "precio_a_facturar"
    t.float "cantidad_faltante"
    t.boolean "entrega_cumplida"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["factura_despacho_id"], name: "index_remisiones_on_factura_despacho_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "cargo"
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tiempos_de_entregas", force: :cascade do |t|
    t.integer "pedido_id"
    t.string "remision", default: ""
    t.float "cantidad", default: 0.0
    t.date "fecha_compromiso"
    t.float "precio", default: 0.0
    t.date "fecha_de_despacho"
    t.float "cantidad_enviada", default: 0.0
    t.float "precio_a_facturar", default: 0.0
    t.float "cantidad_faltante", default: 0.0
    t.boolean "anexo", default: false
    t.boolean "entrega_cumplida", default: false
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pedido_id"], name: "index_tiempos_de_entregas_on_pedido_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nombre"
    t.string "numero_celular"
    t.integer "rol_id"
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rol_id"], name: "index_users_on_rol_id"
  end

end
