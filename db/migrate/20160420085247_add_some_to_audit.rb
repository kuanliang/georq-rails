class AddSomeToAudit < ActiveRecord::Migration
  def change

  	add_column :audits, :lead_auditor_stg2_id , :integer 
  	
  	add_column :audits, :auditor1_stg2_id , :integer

  	add_column :audits, :auditor2_stg2_id , :integer

  	add_column :audits, :auditor_id , :integer

  	add_column :audits, :auditor2_id , :integer
  end
end
