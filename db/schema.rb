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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130729111819) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "bouteilles", :force => true do |t|
    t.string   "appellation"
    t.integer  "type_id"
    t.text     "description"
    t.integer  "cuvee_id"
    t.integer  "domaine_id"
    t.integer  "millesime_id"
    t.decimal  "prix"
    t.boolean  "nouveau"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "volume_id"
    t.integer  "region_id"
  end

  add_index "bouteilles", ["cuvee_id"], :name => "index_bouteilles_on_cuvee_id"
  add_index "bouteilles", ["domaine_id"], :name => "index_bouteilles_on_domaine_id"
  add_index "bouteilles", ["millesime_id"], :name => "index_bouteilles_on_millesime_id"
  add_index "bouteilles", ["region_id"], :name => "index_bouteilles_on_region_id"
  add_index "bouteilles", ["type_id"], :name => "index_bouteilles_on_type_id"
  add_index "bouteilles", ["volume_id"], :name => "index_bouteilles_on_volume_id"

  create_table "bouteilles_catalogues", :force => true do |t|
    t.integer "bouteille_id"
    t.integer "catalogue_id"
  end

  add_index "bouteilles_catalogues", ["bouteille_id"], :name => "index_bouteilles_catalogues_on_bouteille_id"
  add_index "bouteilles_catalogues", ["catalogue_id"], :name => "index_bouteilles_catalogues_on_catalogue_id"

  create_table "catalogues", :force => true do |t|
    t.string   "titre"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "image1_file_name"
    t.string   "image1_content_type"
    t.integer  "image1_file_size"
    t.datetime "image1_updated_at"
    t.string   "image2_file_name"
    t.string   "image2_content_type"
    t.integer  "image2_file_size"
    t.datetime "image2_updated_at"
    t.string   "image3_file_name"
    t.string   "image3_content_type"
    t.integer  "image3_file_size"
    t.datetime "image3_updated_at"
    t.string   "image4_file_name"
    t.string   "image4_content_type"
    t.integer  "image4_file_size"
    t.datetime "image4_updated_at"
    t.string   "image5_file_name"
    t.string   "image5_content_type"
    t.integer  "image5_file_size"
    t.datetime "image5_updated_at"
    t.string   "image6_file_name"
    t.string   "image6_content_type"
    t.integer  "image6_file_size"
    t.datetime "image6_updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "nom"
    t.string   "prenom"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "inactif"
  end

  create_table "cuvees", :force => true do |t|
    t.string   "libelle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "domaines", :force => true do |t|
    t.string   "libelle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "evenements", :force => true do |t|
    t.string   "titre"
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "date_debut"
    t.datetime "date_fin"
    t.integer  "newsletter_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "evenements", ["newsletter_id"], :name => "index_evenements_on_newsletter_id"

  create_table "millesimes", :force => true do |t|
    t.string   "valeur"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "newsletters", :force => true do |t|
    t.string   "titre"
    t.datetime "date_debut"
    t.datetime "date_fin"
    t.string   "info"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.text     "description"
    t.string   "titre_evenement"
    t.string   "evenement_image_file_name"
    t.string   "evenement_image_content_type"
    t.integer  "evenement_image_file_size"
    t.datetime "evenement_image_updated_at"
    t.string   "promotions_titre"
    t.text     "info_description"
    t.string   "statut"
    t.text     "evenement_description"
  end

  create_table "newsletters_bouteilles", :force => true do |t|
    t.integer  "newsletter_id"
    t.integer  "bouteille_id"
    t.decimal  "rabais"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "position"
  end

  add_index "newsletters_bouteilles", ["bouteille_id"], :name => "index_newsletters_bouteilles_on_bouteille_id"
  add_index "newsletters_bouteilles", ["newsletter_id"], :name => "index_newsletters_bouteilles_on_newsletter_id"

  create_table "regions", :force => true do |t|
    t.string   "libelle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "types", :force => true do |t|
    t.string   "libelle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "couleur"
  end

  create_table "volumes", :force => true do |t|
    t.string   "valeur"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
