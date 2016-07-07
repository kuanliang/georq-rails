class AddConsultantrowsToConsultant < ActiveRecord::Migration
  def change
  	add_column :consultants, :consultant_standard , :string
  	add_column :consultants, :consultor , :string
  	add_column :consultants, :comment , :text
  end
end
