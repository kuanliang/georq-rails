class AddSomeToAuditMonthsCustomers < ActiveRecord::Migration
  def change

  	add_column :audit_months_customers, :customer_id , :integer

  	add_column :audit_months_customers, :audit_month_id , :integer
  end
end
