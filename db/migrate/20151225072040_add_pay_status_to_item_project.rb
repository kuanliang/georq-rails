class AddPayStatusToItemProject < ActiveRecord::Migration
  def change
  	add_column :items_projects, :pay_status , :string
  end
end
