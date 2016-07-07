class Service < ActiveRecord::Base
	has_and_belongs_to_many :projects
	has_many :audits
	has_many :consultant
end
