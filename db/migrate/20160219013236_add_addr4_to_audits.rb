class AddAddr4ToAudits < ActiveRecord::Migration
  def change

  	add_column :audits, :address4_chi , :string
  	add_column :audits, :address4_eng , :string
  end
end
