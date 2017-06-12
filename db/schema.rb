# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170329151809) do

  create_table "administracion_controladors", force: true do |t|
    t.string   "subject_class"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administracion_grupos", force: true do |t|
    t.string   "nombre",     limit: 30
    t.boolean  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administracion_grupos_usuarios", id: false, force: true do |t|
    t.integer "grupo_id",   null: false
    t.integer "usuario_id", null: false
  end

  add_index "administracion_grupos_usuarios", ["grupo_id", "usuario_id"], name: "index_administracion_grupos_usuarios_on_grupo_id_and_usuario_id", using: :btree

  create_table "administracion_permiso_grupos", force: true do |t|
    t.integer  "permiso_id"
    t.integer  "grupo_id"
    t.boolean  "estado",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administracion_permiso_grupos", ["grupo_id"], name: "index_administracion_permiso_grupos_on_grupo_id", using: :btree
  add_index "administracion_permiso_grupos", ["permiso_id"], name: "index_administracion_permiso_grupos_on_permiso_id", using: :btree

  create_table "administracion_permiso_usuarios", force: true do |t|
    t.integer  "usuario_id"
    t.integer  "permiso_id"
    t.boolean  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administracion_permisos", force: true do |t|
    t.string   "nombre"
    t.integer  "controlador_id"
    t.string   "accion"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "administracion_usuarios", force: true do |t|
    t.string   "username",               limit: 15
    t.string   "cedula",                 limit: 10
    t.string   "nombres",                limit: 40
    t.string   "string",                 limit: 250
    t.string   "apellidos",              limit: 40
    t.string   "celular",                limit: 15
    t.string   "telefono",               limit: 15
    t.string   "direccion",              limit: 250
    t.boolean  "estado",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                              default: "",    null: false
    t.string   "encrypted_password",                 default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "compra",                             default: false
    t.string   "unidad_id"
  end

  add_index "administracion_usuarios", ["email"], name: "index_administracion_usuarios_on_email", unique: true, using: :btree
  add_index "administracion_usuarios", ["reset_password_token"], name: "index_administracion_usuarios_on_reset_password_token", unique: true, using: :btree

  create_table "articulos_plantillas", id: false, force: true do |t|
    t.integer "plantilla_id", null: false
    t.string  "articulo_id"
    t.string  "codemp"
  end

  add_index "articulos_plantillas", ["plantilla_id"], name: "index_articulos_plantillas_on_plantilla_id", using: :btree

  create_table "plantillas", force: true do |t|
    t.string   "nombre",      limit: 30
    t.string   "descripcion", limit: 250
    t.boolean  "compra"
    t.integer  "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plantillas_servicios", id: false, force: true do |t|
    t.integer "plantilla_id", null: false
    t.string  "servicio_id"
    t.string  "codemp"
  end

  add_index "plantillas_servicios", ["plantilla_id"], name: "index_plantillas_servicios_on_plantilla_id", using: :btree

  create_table "solicitud_grupos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solicitudesgrupos", id: false, force: true do |t|
    t.string  "solicitud_id"
    t.integer "grupo_id"
  end

  add_index "solicitudesgrupos", ["grupo_id"], name: "index_solicitudesgrupos_on_grupo_id", using: :btree

  create_table "usuario_unidades", id: false, force: true do |t|
    t.integer "usuario_id"
    t.string  "unidad_id"
  end

  add_foreign_key "administracion_grupos_usuarios", "administracion_grupos", name: "administracion_grupos_usuarios_grupo_id_fk", column: "grupo_id"
  add_foreign_key "administracion_grupos_usuarios", "administracion_usuarios", name: "administracion_grupos_usuarios_usuario_id_fk", column: "usuario_id"

  add_foreign_key "articulos_plantillas", "plantillas", name: "articulos_plantillas_plantilla_id_fk"

end
