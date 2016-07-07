class AddRealAuditorToAudits < ActiveRecord::Migration
  def change

  	add_column :audits, :real_auditor , :string
  end
end
