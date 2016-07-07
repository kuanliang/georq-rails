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

ActiveRecord::Schema.define(version: 20160519062905) do

  create_table "audit_months", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "audit_months_customers", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "customer_id"
    t.integer  "audit_month_id"
  end

  create_table "audits", force: :cascade do |t|
    t.string   "audit_id"
    t.integer  "project_id"
    t.string   "certification_body"
    t.string   "CB_number"
    t.string   "audit_type"
    t.string   "audit_standard"
    t.string   "EA_CODE"
    t.string   "ISO9000_exclusions"
    t.string   "man_day"
    t.text     "scope_chi"
    t.text     "scope_eng"
    t.string   "address1_chi"
    t.string   "address1_eng"
    t.string   "address2_chi"
    t.string   "address2_eng"
    t.string   "address3_chi"
    t.string   "address3_eng"
    t.string   "lead_auditor"
    t.string   "auditor"
    t.string   "specialist"
    t.string   "train_auditor"
    t.date     "prepare_opendate"
    t.date     "prepare_closedate"
    t.date     "audit_opendate"
    t.date     "audit_closedate"
    t.text     "comment"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "real_audit_date"
    t.string   "real_audit_time"
    t.date     "report_get_date"
    t.date     "report_send_date"
    t.date     "certificate_get_date"
    t.date     "certificate_send_date"
    t.string   "status"
    t.integer  "service_id"
    t.string   "address4_chi"
    t.string   "address4_eng"
    t.integer  "parent_audit_id"
    t.string   "audit_name"
    t.integer  "brother_audit_id"
    t.string   "auditor2"
    t.string   "real_auditor"
    t.string   "man_day_stg2"
    t.string   "lead_auditor_stg2"
    t.string   "auditor1_stg2"
    t.string   "auditor2_stg2"
    t.string   "specialist_stg2"
    t.string   "train_auditor_stg2"
    t.date     "prepare_opendate_stg2"
    t.date     "prepare_closedate_stg2"
    t.date     "audit_opendate_stg2"
    t.date     "audit_closedate_stg2"
    t.integer  "lead_auditor_id"
    t.integer  "lead_auditor_stg2_id"
    t.integer  "auditor1_stg2_id"
    t.integer  "auditor2_stg2_id"
    t.integer  "auditor_id"
    t.integer  "auditor2_id"
  end

  create_table "audits_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tag_id"
    t.integer  "audit_id"
  end

  create_table "certificates", force: :cascade do |t|
    t.integer  "audit_id"
    t.string   "certificate_num"
    t.string   "certificate_type"
    t.date     "initial_date"
    t.date     "issue_date"
    t.date     "expiration_date"
    t.string   "status"
    t.string   "comment"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "company_name"
    t.string   "company_address"
    t.string   "company_tel"
    t.string   "company_fax"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "companies_items", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consultant_classes", force: :cascade do |t|
    t.integer  "consultant_id"
    t.string   "class_content"
    t.date     "class_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "consultants", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "contract_date"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "consultant_standard"
    t.string   "consultor"
    t.text     "comment"
    t.integer  "service_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "customer_num"
    t.string   "identification_num"
    t.string   "customer_chi"
    t.string   "customer_eng"
    t.string   "owner"
    t.integer  "staff_num"
    t.integer  "site_num"
    t.string   "mr_chi"
    t.string   "mr_eng"
    t.string   "mr_pos"
    t.string   "fax_num"
    t.string   "contact_tel"
    t.string   "contact_email"
    t.string   "contact_ppl"
    t.string   "contact_addr"
    t.string   "office_addr_chi"
    t.string   "office_addr_eng"
    t.string   "factory_addr_cht"
    t.string   "factory_addr_eng"
    t.string   "level"
    t.text     "comment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "orginal_audit_date"
    t.string   "CB_number"
    t.string   "certification_body"
    t.string   "audit_standard"
    t.string   "scope_chi"
    t.string   "scope_eng"
    t.date     "stop_date"
    t.boolean  "stop"
    t.string   "stop_reason"
  end

  create_table "customers_tags", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "data_files", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_lists", force: :cascade do |t|
    t.string   "form"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forms", force: :cascade do |t|
    t.string   "name"
    t.string   "background"
    t.string   "background2"
    t.string   "background3"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.boolean  "follow"
    t.string   "describe"
    t.string   "version"
    t.string   "standard"
    t.string   "company"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "level"
    t.integer  "user_id"
    t.integer  "posts_count", default: 0
  end

  create_table "items", force: :cascade do |t|
    t.string   "contract_name"
    t.string   "invoice_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "company_id"
  end

  create_table "items_projects", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "project_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "ratio"
    t.string   "pay_status"
    t.string   "get_money_people"
    t.date     "get_money_date"
  end

  create_table "lead_auditors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_en"
    t.string   "name_chi"
  end

  create_table "office_open_xmls", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "name"
    t.date     "date"
    t.string   "company"
    t.string   "classname"
    t.string   "teacher"
    t.string   "content2"
    t.string   "content3"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "customer_num"
    t.string   "all_audit_standard"
    t.datetime "real_audit_date"
    t.string   "real_audit_time"
    t.string   "project_manager"
    t.datetime "report_get_date"
    t.datetime "report_send_date"
    t.datetime "certificate_get_date"
    t.datetime "certificate_send_date"
    t.string   "pay_status"
    t.string   "status"
    t.text     "comment"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "customer_id"
    t.string   "audit_date"
    t.string   "kind"
    t.integer  "total_amount"
    t.string   "currency"
    t.string   "project_type"
    t.string   "partyb"
    t.date     "contract_start_date"
    t.string   "contract_file_name"
    t.string   "contract_content_type"
    t.integer  "contract_file_size"
    t.datetime "contract_updated_at"
  end

  create_table "projects_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.integer  "item_id"
  end

  create_table "projects_services", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.integer  "service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "alias"
    t.string   "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "tag_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "follow"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
