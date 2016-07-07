class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.string :audit_id
      t.integer :project_id
      t.string :certification_body
      t.string :CB_number
      t.string :audit_type
      t.string :audit_standard
      t.string :EA_CODE
      t.string :ISO9000_exclusions
      t.string :man_day
      t.text :scope_chi
      t.text :scope_eng
      t.string :address1_chi
      t.string :address1_eng
      t.string :address2_chi
      t.string :address2_eng
      t.string :address3_chi
      t.string :address3_eng
      t.string :lead_auditor
      t.string :auditor
      t.string :specialist
      t.string :train_auditor
      t.datetime :prepare_opendate
      t.datetime :prepare_closedate
      t.datetime :audit_opendate
      t.datetime :audit_closedate
      t.text :comment

      t.timestamps null: false
    end
  end
end
