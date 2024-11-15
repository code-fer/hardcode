# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_14_194429) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "retos", force: :cascade do |t|
    t.string "nombre"
    t.text "descripcion"
    t.string "fuente"
    t.integer "dificultad"
    t.string "empresa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solucions", force: :cascade do |t|
    t.string "url"
    t.text "descripcion"
    t.bigint "user_id", null: false
    t.bigint "reto_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "puntuacion"
    t.index ["reto_id"], name: "index_solucions_on_reto_id"
    t.index ["user_id"], name: "index_solucions_on_user_id"
  end

  create_table "userdata", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre_usuario"
    t.integer "puntuacion"
    t.string "rrss_1"
    t.string "rrss_2"
    t.string "rrss_3"
    t.bigint "user_id", null: false
    t.string "tipo"
    t.string "nombre_apellidos"
    t.integer "ntelefono"
    t.index ["user_id"], name: "index_userdata_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "solucion_id", null: false
    t.bigint "reto_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "votado_por_user_id"
    t.index ["reto_id"], name: "index_votos_on_reto_id"
    t.index ["solucion_id"], name: "index_votos_on_solucion_id"
    t.index ["user_id", "reto_id"], name: "index_votos_on_user_id_and_reto_id", unique: true
    t.index ["user_id"], name: "index_votos_on_user_id"
  end

  add_foreign_key "solucions", "retos"
  add_foreign_key "userdata", "users"
  add_foreign_key "votos", "retos"
  add_foreign_key "votos", "solucions"
end
