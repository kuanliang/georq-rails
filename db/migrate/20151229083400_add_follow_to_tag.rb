class AddFollowToTag < ActiveRecord::Migration
  def change
  	add_column :tags, :follow , :boolean 
  end
end
