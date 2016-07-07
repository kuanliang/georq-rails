class AddCustomerIdToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :customer_id, :integer
  end
end
