class AddServiceToForm < ActiveRecord::Migration
  def change
  	add_column :forms, :standard , :string
  	add_column :forms, :company , :string
  end
end
