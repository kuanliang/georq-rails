class AddSomeToLeadAuditor < ActiveRecord::Migration
  def change
  	add_column :lead_auditors, :name_en , :string
  	add_column :lead_auditors, :name_chi , :string
  end
end
