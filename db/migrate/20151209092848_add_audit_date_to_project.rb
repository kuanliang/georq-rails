class AddAuditDateToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :audit_date, :string
  end
end
