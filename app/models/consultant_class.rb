class ConsultantClass < ActiveRecord::Base
	scope :near_month, -> { where(:class_date => Time.now.beginning_of_month-30..Time.now.end_of_month+30) }
	scope :this_month, -> { where(:class_date => Time.now.beginning_of_month..Time.now.end_of_month) }
	 #scope :this_month, -> { order("customer_num DESC") }
	scope :selected_month, ->(date){ where(:class_date => date.beginning_of_month..date.end_of_month) }
	belongs_to :consultant
end
