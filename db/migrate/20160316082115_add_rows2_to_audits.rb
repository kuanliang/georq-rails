class AddRows2ToAudits < ActiveRecord::Migration
  def change
  	add_column :audits, :man_day_stg2 , :string
  	add_column :audits, :lead_auditor_stg2 , :string
  	add_column :audits, :auditor1_stg2 , :string
  	add_column :audits, :auditor2_stg2 , :string

  	add_column :audits, :specialist_stg2 , :string
  	add_column :audits, :train_auditor_stg2 , :string

  	add_column :audits, :prepare_opendate_stg2 , :string
  	add_column :audits, :prepare_closedate_stg2 , :string


  	add_column :audits, :audit_opendate_stg2 , :string
  	add_column :audits, :audit_closedate_stg2 , :string
  end
end
  