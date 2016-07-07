class CreateAuditMonths < ActiveRecord::Migration
  def change
    create_table :audit_months do |t|

      t.timestamps null: false
    end
  end
end
