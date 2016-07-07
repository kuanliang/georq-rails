class AddServiceIdToCons < ActiveRecord::Migration
  def change
  	add_column :consultants, :service_id , :integer 
  end
end
