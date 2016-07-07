class Consultant < ActiveRecord::Base
					scope :near_month, -> { where(:contract_date => Time.now.beginning_of_month-30..Time.now.end_of_month+30) }
					scope :this_month, -> { where(:contract_date => Time.now.beginning_of_month..Time.now.end_of_month) }
					 #scope :this_month, -> { order("customer_num DESC") }
					scope :selected_month, ->(date){ where(:contract_date => date.beginning_of_month..date.end_of_month) }
					belongs_to :project 
					belongs_to :service 
	 has_many :consultant_classes, dependent: :destroy
	 accepts_nested_attributes_for :consultant_classes, :reject_if => :all_blank, :allow_destroy => true

end
