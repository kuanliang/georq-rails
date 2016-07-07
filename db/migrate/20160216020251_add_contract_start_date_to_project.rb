class AddContractStartDateToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :contract_start_date , :date
  end
end
