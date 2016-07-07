class AddSomeToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :company , :string
  	add_column :posts, :classname , :string
  	add_column :posts, :teacher , :string
  	add_column :posts, :content2 , :string
  	add_column :posts, :content3 , :string
  end
end
