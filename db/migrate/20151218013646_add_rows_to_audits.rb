class AddRowsToAudits < ActiveRecord::Migration
  def change
  	add_column :audits, :real_audit_date , :datetime
  	add_column :audits, :real_autit_time , :string
  	add_column :audits, :report_get_date , :date
  	add_column :audits, :report_send_date , :date
  	add_column :audits, :certificate_get_date , :date
  	add_column :audits, :certificate_send_date , :date
  	add_column :audits, :status , :string
  end
end
