class AuditMonth < ActiveRecord::Base
	has_and_belongs_to_many :customers
end
