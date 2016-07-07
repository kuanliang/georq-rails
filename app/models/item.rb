class Item < ActiveRecord::Base
	has_and_belongs_to_many :projects
	
	has_many :items_projects
	belongs_to :company
end
