class AddRatioToItemProject < ActiveRecord::Migration
  def change
  	add_column :items_projects, :ratio , :integer
  end
end
