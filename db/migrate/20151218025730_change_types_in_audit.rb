class ChangeTypesInAudit < ActiveRecord::Migration
  def change
  	change_column :audits, :prepare_opendate, :date
  	change_column :audits, :prepare_closedate, :date
  	change_column :audits, :audit_opendate, :date
  	change_column :audits, :audit_closedate, :date
  	change_column :audits, :real_audit_date, :datetime
  	change_column :audits, :report_get_date, :date
  	change_column :audits, :report_send_date, :date
  	change_column :audits, :certificate_get_date, :date
  	change_column :audits, :certificate_send_date, :date
  end
end
 
