class AddRowsToProjectsItems < ActiveRecord::Migration
  def change
  	add_column :projects_items, :project_id , :integer

  	add_column :projects_items, :item_id , :integer
  end
end
