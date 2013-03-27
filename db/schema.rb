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

ActiveRecord::Schema.define(:version => 20130327072239) do

  add_extension "hstore"

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

  create_table "apps", :force => true do |t|
    t.string   "name",                                    :null => false
    t.string   "state",                :default => "new", :null => false
    t.integer  "developer_profile_id",                    :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.text     "desc"
    t.string   "icon"
    t.integer  "current_bundle_id"
    t.integer  "kind_id",                                 :null => false
  end

  add_index "apps", ["kind_id"], :name => "index_apps_on_kind_id"
  add_index "apps", ["name"], :name => "index_apps_on_name", :unique => true

  create_table "bundles", :force => true do |t|
    t.text     "changelog"
    t.datetime "created_at",                                                                                 :null => false
    t.datetime "updated_at",                                                                                 :null => false
    t.string   "source_file"
    t.string   "bundle_file"
    t.string   "state"
    t.string   "uuid",                                   :default => "7112ded0-1f9b-0130-60de-746d04736cf8", :null => false
    t.integer  "app_id",                                                                                     :null => false
    t.text     "supported_kernel_versions"
    t.integer  "version_number",            :limit => 8, :default => 10000,                                  :null => false
    t.string   "name",                                                                                       :null => false
    t.integer  "kind_id",                                                                                    :null => false
  end

  add_index "bundles", ["app_id", "version_number"], :name => "index_bundles_on_app_id_and_version", :unique => true
  add_index "bundles", ["app_id"], :name => "index_bundles_on_app_id"
  add_index "bundles", ["kind_id"], :name => "index_bundles_on_kind_id"
  add_index "bundles", ["name"], :name => "index_bundles_on_name"
  add_index "bundles", ["state"], :name => "index_bundles_on_state"
  add_index "bundles", ["uuid"], :name => "index_bundles_on_uuid", :unique => true

  create_table "configurations", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "configurations", ["name"], :name => "index_configurations_on_name", :unique => true

  create_table "developer_profiles", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "avatar"
    t.integer  "apps_count", :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "developer_profiles", ["apps_count"], :name => "index_developer_profiles_on_apps_count"
  add_index "developer_profiles", ["name"], :name => "index_developer_profiles_on_name", :unique => true

  create_table "kinds", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "ext",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "supported_configurations", :force => true do |t|
    t.integer  "bundle_id",        :null => false
    t.integer  "configuration_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "versions"
  end

  add_index "supported_configurations", ["bundle_id"], :name => "sc_idx2"
  add_index "supported_configurations", ["configuration_id", "bundle_id"], :name => "sc_idx"

  create_table "user_systems", :force => true do |t|
    t.string   "name"
    t.integer  "kernel_version_number",        :limit => 8, :null => false
    t.integer  "configuration_id"
    t.integer  "configuration_version_number", :limit => 8
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                           :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "name"
    t.integer  "developer_profile_id"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["developer_profile_id"], :name => "index_users_on_developer_profile_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
