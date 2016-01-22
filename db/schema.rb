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

ActiveRecord::Schema.define(version: 20160122030959) do

  create_table "blacklists", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",     limit: 4,   null: false
    t.string   "pattern",     limit: 255, null: false
    t.string   "description", limit: 160
  end

  add_index "blacklists", ["pattern"], name: "pattern", unique: true, using: :btree

  create_table "migrate_version", primary_key: "repository_id", force: :cascade do |t|
    t.text    "repository_path", limit: 65535
    t.integer "version",         limit: 4
  end

  create_table "pool_attributes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",    limit: 4,   null: false
    t.string   "key",        limit: 255, null: false
    t.string   "value",      limit: 255, null: false
    t.string   "pool_id",    limit: 32,  null: false
  end

  add_index "pool_attributes", ["pool_id", "key", "value"], name: "unique_pool_attribute", unique: true, using: :btree

  create_table "pool_ns_records", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",    limit: 4,   null: false
    t.string   "pool_id",    limit: 32,  null: false
    t.integer  "priority",   limit: 4,   null: false
    t.string   "hostname",   limit: 255, null: false
  end

  add_index "pool_ns_records", ["pool_id"], name: "pool_id", using: :btree

  create_table "pools", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",     limit: 4,                         null: false
    t.string   "name",        limit: 50,                        null: false
    t.string   "description", limit: 160
    t.string   "tenant_id",   limit: 36
    t.string   "provisioner", limit: 9,   default: "UNMANAGED", null: false
  end

  add_index "pools", ["name"], name: "unique_pool_name", unique: true, using: :btree

  create_table "quotas", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",    limit: 4,  null: false
    t.string   "tenant_id",  limit: 36, null: false
    t.string   "resource",   limit: 32, null: false
    t.integer  "hard_limit", limit: 4,  null: false
  end

  add_index "quotas", ["tenant_id", "resource"], name: "unique_quota", unique: true, using: :btree

  create_table "records", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",                 limit: 4,                         null: false
    t.text     "data",                    limit: 65535,                     null: false
    t.string   "zone_id",                 limit: 32,                        null: false
    t.boolean  "managed"
    t.string   "managed_resource_type",   limit: 50
    t.string   "managed_resource_id",     limit: 32
    t.string   "managed_plugin_name",     limit: 50
    t.string   "managed_plugin_type",     limit: 50
    t.string   "hash",                    limit: 32,                        null: false
    t.string   "description",             limit: 160
    t.string   "status",                  limit: 7,     default: "PENDING", null: false
    t.string   "tenant_id",               limit: 36
    t.string   "recordset_id",            limit: 32,                        null: false
    t.string   "managed_tenant_id",       limit: 36
    t.string   "managed_resource_region", limit: 100
    t.string   "managed_extra",           limit: 100
    t.string   "action",                  limit: 6,     default: "CREATE",  null: false
    t.integer  "serial",                  limit: 4,     default: 1,         null: false
    t.integer  "zone_shard",              limit: 2,                         null: false
  end

  add_index "records", ["created_at"], name: "record_created_at", using: :btree
  add_index "records", ["hash"], name: "unique_record", unique: true, using: :btree
  add_index "records", ["recordset_id"], name: "fkey_records_recordset_id", using: :btree
  add_index "records", ["status", "zone_id", "tenant_id", "created_at", "serial"], name: "update_status_index", using: :btree
  add_index "records", ["tenant_id"], name: "records_tenant", using: :btree
  add_index "records", ["zone_id"], name: "records_zone_id_fkey", using: :btree

  create_table "recordsets", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",      limit: 4,                null: false
    t.string   "tenant_id",    limit: 36
    t.string   "zone_id",      limit: 32,               null: false
    t.string   "name",         limit: 255,              null: false
    t.string   "type",         limit: 5,                null: false
    t.integer  "ttl",          limit: 4
    t.string   "description",  limit: 160
    t.string   "reverse_name", limit: 255, default: "", null: false
    t.integer  "zone_shard",   limit: 2,                null: false
  end

  add_index "recordsets", ["created_at"], name: "recordset_created_at", using: :btree
  add_index "recordsets", ["reverse_name", "zone_id"], name: "reverse_name_dom_id", using: :btree
  add_index "recordsets", ["type", "name"], name: "recordset_type_name", using: :btree
  add_index "recordsets", ["type", "zone_id"], name: "rrset_type_domainid", using: :btree
  add_index "recordsets", ["zone_id", "name", "type"], name: "unique_recordset", unique: true, using: :btree

  create_table "servers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "status",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tlds", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",     limit: 4,   null: false
    t.string   "name",        limit: 255, null: false
    t.string   "description", limit: 160
  end

  add_index "tlds", ["name"], name: "unique_tld_name", unique: true, using: :btree

  create_table "tsigkeys", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",     limit: 4,                    null: false
    t.string   "name",        limit: 255,                  null: false
    t.string   "algorithm",   limit: 11,                   null: false
    t.string   "secret",      limit: 255,                  null: false
    t.string   "scope",       limit: 4,   default: "POOL", null: false
    t.string   "resource_id", limit: 32,                   null: false
  end

  add_index "tsigkeys", ["name"], name: "unique_tsigkey_name", unique: true, using: :btree

  create_table "zone_attributes", force: :cascade do |t|
    t.integer  "version",    limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key",        limit: 6
    t.string   "value",      limit: 255, null: false
    t.string   "zone_id",    limit: 32,  null: false
  end

  add_index "zone_attributes", ["key", "value", "zone_id"], name: "unique_attributes", unique: true, using: :btree
  add_index "zone_attributes", ["zone_id"], name: "zone_attributes_zone_id_fkey", using: :btree

  create_table "zone_tasks", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",    limit: 4,                      null: false
    t.string   "tenant_id",  limit: 36
    t.string   "zone_id",    limit: 32
    t.string   "task_type",  limit: 6
    t.string   "message",    limit: 160
    t.string   "status",     limit: 8,   default: "ACTIVE", null: false
    t.string   "location",   limit: 160
  end

  add_index "zone_tasks", ["zone_id"], name: "zone_tasks_zone_id_fkey", using: :btree

  create_table "zone_transfer_accepts", force: :cascade do |t|
    t.string   "zone_id",                  limit: 32,                    null: false
    t.string   "zone_transfer_request_id", limit: 32,                    null: false
    t.string   "status",                   limit: 8,  default: "ACTIVE", null: false
    t.string   "tenant_id",                limit: 36,                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",                  limit: 4,                     null: false
  end

  add_index "zone_transfer_accepts", ["zone_id"], name: "zone_transfer_accepts_zone_id_fkey", using: :btree
  add_index "zone_transfer_accepts", ["zone_transfer_request_id"], name: "zone_transfer_request_id", using: :btree

  create_table "zone_transfer_requests", force: :cascade do |t|
    t.string   "zone_id",          limit: 32,                     null: false
    t.string   "key",              limit: 255,                    null: false
    t.string   "description",      limit: 255
    t.string   "tenant_id",        limit: 36,                     null: false
    t.string   "target_tenant_id", limit: 36
    t.string   "status",           limit: 8,   default: "ACTIVE", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",          limit: 4,                      null: false
  end

  add_index "zone_transfer_requests", ["zone_id"], name: "zone_transfer_requests_zone_id_fkey", using: :btree

  create_table "zones", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version",        limit: 4,                       null: false
    t.string   "tenant_id",      limit: 36
    t.string   "name",           limit: 255,                     null: false
    t.string   "email",          limit: 255,                     null: false
    t.integer  "ttl",            limit: 4,                       null: false
    t.integer  "refresh",        limit: 4,                       null: false
    t.integer  "retry",          limit: 4,                       null: false
    t.integer  "expire",         limit: 4,                       null: false
    t.integer  "minimum",        limit: 4,                       null: false
    t.string   "parent_zone_id", limit: 32
    t.integer  "serial",         limit: 4,   default: 1,         null: false
    t.string   "deleted",        limit: 32,  default: "0",       null: false
    t.datetime "deleted_at"
    t.string   "description",    limit: 160
    t.string   "status",         limit: 7,   default: "PENDING", null: false
    t.string   "action",         limit: 6,   default: "CREATE",  null: false
    t.string   "pool_id",        limit: 32
    t.string   "reverse_name",   limit: 255, default: "",        null: false
    t.string   "type",           limit: 9,   default: "PRIMARY"
    t.datetime "transferred_at"
    t.integer  "shard",          limit: 2,                       null: false
  end

  add_index "zones", ["created_at"], name: "zone_created_at", using: :btree
  add_index "zones", ["deleted"], name: "zone_deleted", using: :btree
  add_index "zones", ["name", "deleted", "pool_id"], name: "unique_domain_name", unique: true, using: :btree
  add_index "zones", ["parent_zone_id"], name: "zones_parent_zone_id_fkey", using: :btree
  add_index "zones", ["reverse_name", "deleted"], name: "reverse_name_deleted", using: :btree
  add_index "zones", ["tenant_id", "deleted"], name: "zone_tenant_deleted", using: :btree

  add_foreign_key "pool_attributes", "pools", name: "pool_attributes_ibfk_1", on_delete: :cascade
  add_foreign_key "pool_ns_records", "pools", name: "pool_ns_records_ibfk_1", on_delete: :cascade
  add_foreign_key "records", "recordsets", name: "fkey_records_recordset_id", on_delete: :cascade
  add_foreign_key "records", "zones", name: "records_zone_id_fkey", on_delete: :cascade
  add_foreign_key "recordsets", "zones", name: "recordsets_zone_id_fkey", on_delete: :cascade
  add_foreign_key "zone_attributes", "zones", name: "zone_attributes_zone_id_fkey", on_delete: :cascade
  add_foreign_key "zone_tasks", "zones", name: "zone_tasks_zone_id_fkey", on_delete: :cascade
  add_foreign_key "zone_transfer_accepts", "zone_transfer_requests", name: "zone_transfer_accepts_ibfk_2", on_delete: :cascade
  add_foreign_key "zone_transfer_accepts", "zones", name: "zone_transfer_accepts_zone_id_fkey", on_delete: :cascade
  add_foreign_key "zone_transfer_requests", "zones", name: "zone_transfer_requests_zone_id_fkey", on_delete: :cascade
  add_foreign_key "zones", "zones", column: "parent_zone_id", name: "zones_parent_zone_id_fkey", on_delete: :nullify
end
