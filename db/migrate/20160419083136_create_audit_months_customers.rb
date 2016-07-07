class CreateAuditMonthsCustomers < ActiveRecord::Migration
  def change
    create_table :audit_months_customers do |t|

      t.timestamps null: false
    end
  end
end
