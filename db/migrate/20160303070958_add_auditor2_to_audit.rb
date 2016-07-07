class AddAuditor2ToAudit < ActiveRecord::Migration
  def change
  	add_column :audits, :auditor2 , :string
  end
end
