class ChangeAuditnameTypeFromAudit < ActiveRecord::Migration
  def change
  	change_column :audits, :audit_name, :string
  end
end
