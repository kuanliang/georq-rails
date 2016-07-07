class RemoveProjectIdFromProject < ActiveRecord::Migration
  def change
  	remove_column :projects, :project_id, :string
  end
end
