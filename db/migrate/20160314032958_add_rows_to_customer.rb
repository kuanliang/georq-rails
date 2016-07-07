class AddRowsToCustomer < ActiveRecord::Migration
  def change

  	add_column :customers, :stop_date , :date
  	add_column :customers, :stop , :boolean 
  	add_column :customers, :stop_reason , :string
  end
end
