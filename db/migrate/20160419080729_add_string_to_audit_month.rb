class AddStringToAuditMonth < ActiveRecord::Migration
  def change
  	add_column :audit_months, :name , :string
  end
end
