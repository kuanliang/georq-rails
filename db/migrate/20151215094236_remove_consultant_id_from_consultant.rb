class RemoveConsultantIdFromConsultant < ActiveRecord::Migration
  def change
  	remove_column :consultants , :consultant_id, :string
  end
end
