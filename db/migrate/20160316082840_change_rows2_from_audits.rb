class ChangeRows2FromAudits < ActiveRecord::Migration
  def change
  	change_column :audits, :prepare_opendate_stg2, :date
  	change_column :audits, :prepare_closedate_stg2, :date
  	change_column :audits, :audit_opendate_stg2, :date
  	change_column :audits, :audit_closedate_stg2, :date
  end
end
