class RemoveProjectIdFromProjectsServices < ActiveRecord::Migration
  def change

  	remove_column :projects_services, :project_id, :string

  	remove_column :projects_services, :service_id, :string
  end
end
