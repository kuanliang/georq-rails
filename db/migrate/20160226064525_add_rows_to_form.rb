class AddRowsToForm < ActiveRecord::Migration
  def change
  	add_column :forms, :follow , :boolean
  	add_column :forms, :describe , :string
  	add_column :forms, :version , :string
  end
end
