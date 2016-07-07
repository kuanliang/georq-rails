class AddIdToProjectsServices < ActiveRecord::Migration
  def change

  	add_column :projects_services, :project_id , :integer

  	add_column :projects_services, :service_id , :integer
  end
end
