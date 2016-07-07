class AddOrginalAuditDate < ActiveRecord::Migration
  def change
  	add_column :customers, :orginal_audit_date , :string

  	add_column :customers, :CB_number , :string
  	add_column :customers, :certification_body , :string
  	add_column :customers, :audit_standard , :string

  	add_column :customers, :scope_chi , :string

  	add_column :customers, :scope_eng , :string
  end
end
