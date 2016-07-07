class ItemsProject < ActiveRecord::Base
	scope :near_month, -> { where(:get_money_date => Time.now.beginning_of_month-30..Time.now.end_of_month+30) }
	scope :this_month, -> { where(:get_money_date => Time.now.beginning_of_month..Time.now.end_of_month) }
	 #scope :this_month, -> { order("customer_num DESC") }
	scope :selected_month, ->(date){ where(:get_money_date => date.beginning_of_month..date.end_of_month) }
	
  belongs_to :project
  belongs_to :item
end
