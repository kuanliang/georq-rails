class AddTotalAmountToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :total_amount, :integer
  	add_column :projects, :currency, :string
  end
end
