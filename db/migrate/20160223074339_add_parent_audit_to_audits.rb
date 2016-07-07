class AddParentAuditToAudits < ActiveRecord::Migration
  def change
  	add_column :audits, :parent_audit_id , :integer
  end
end
