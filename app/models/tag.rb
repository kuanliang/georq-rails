class Tag < ActiveRecord::Base

	has_and_belongs_to_many :customers
	#has_and_belongs_to_many :audits , through: :customers
	has_many :customers_tags
	#belongs_to :project

	#has_many :customers ,	:through => :customers_tag 
	scope :selected_tag, ->(tag){ where(:tag_name => tag) }
end
