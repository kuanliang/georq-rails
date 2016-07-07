class AddServiceIdToAudit < ActiveRecord::Migration
  def change
  	add_column :audits, :service_id , :integer 
  end
end
