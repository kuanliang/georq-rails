class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_id
      t.string :customer_num
      t.string :all_audit_standard
      t.datetime :real_audit_date
      t.string :real_audit_time
      t.string :project_manager
      t.datetime :report_get_date
      t.datetime :report_send_date
      t.datetime :certificate_get_date
      t.datetime :certificate_send_date
      t.string :pay_status
      t.string :status
      t.text :comment

      t.timestamps null: false
    end
  end
end
