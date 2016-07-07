class AddTogetherAuditToAudits < ActiveRecord::Migration
  def change
  	add_column :audits, :brother_audit_id , :integer
  end
end
