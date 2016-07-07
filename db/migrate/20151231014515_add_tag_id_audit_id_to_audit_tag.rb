class AddTagIdAuditIdToAuditTag < ActiveRecord::Migration
  def change
	add_column :audits_tags, :tag_id , :integer 
  	add_column :audits_tags, :audit_id , :integer 
  end
end
