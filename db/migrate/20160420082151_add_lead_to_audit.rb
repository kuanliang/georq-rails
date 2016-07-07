class AddLeadToAudit < ActiveRecord::Migration
  def change

  	add_column :audits, :lead_auditor_id , :integer 
  end
end
