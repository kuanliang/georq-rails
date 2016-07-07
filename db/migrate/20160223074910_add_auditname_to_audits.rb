class AddAuditnameToAudits < ActiveRecord::Migration
  def change
  	add_column :audits, :audit_name , :integer
  end
end
