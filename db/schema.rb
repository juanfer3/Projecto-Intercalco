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

ActiveRecord::Schema.define(version: 20171128121338) do

  create_table "clientes", force: :cascade do |t|
    t.string "nombre", default: ""
    t.string "nit", default: ""
    t.string "direccion", default: ""
    t.string "telefono", default: ""
    t.string "correo", default: ""
    t.integer "user_id"
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clientes_on_user_id"
  end

  create_table "contactos", force: :cascade do |t|
    t.string "nombre_contacto", default: ""
    t.string "telefono", default: ""
    t.string "celular", default: ""
    t.string "correo", default: ""
    t.integer "cliente_id"
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_contactos_on_cliente_id"
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

  create_table "lineas_de_impresiones", force: :cascade do |t|
    t.string "tipo_de_linea", default: ""
    t.string "descripcion", default: ""
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pedidos", force: :cascade do |t|
    t.integer "contacto_id"
    t.string "producto", default: ""
    t.string "tipo_de_trabajo", default: ""
    t.string "condicion_de_pedido", default: ""
    t.date "fecha_entrega"
    t.date "fecha_de_pedido"
    t.string "numero_cotizacion", default: ""
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
    t.index ["contacto_id"], name: "index_pedidos_on_contacto_id"
    t.index ["linea_de_impresion_id"], name: "index_pedidos_on_linea_de_impresion_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "cargo"
    t.boolean "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tiempos_de_entregas", force: :cascade do |t|
    t.integer "pedido_id"
    t.float "cantidad", default: 0.0
    t.date "fecha_compromiso"
    t.float "precio", default: 0.0
    t.boolean "estado", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pedido_id"], name: "index_tiempos_de_entregas_on_pedido_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nombre"
    t.string "numero_celular"
    t.integer "rol_id"
    t.boolean "estado"
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
