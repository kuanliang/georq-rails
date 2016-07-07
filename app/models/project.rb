class Project < ActiveRecord::Base
	#validates_presence_of :contract_start_date

	#validates :contract_start_date, :presence => true
	scope :near_month, -> { where(:real_audit_date => Time.now.beginning_of_month-30..Time.now.end_of_month+30) }
	scope :this_month, -> { where(:real_audit_date => Time.now.beginning_of_month..Time.now.end_of_month) }
	 #scope :this_month, -> { order("customer_num DESC") }
	scope :selected_month, ->(date){ where(:real_audit_date => date.beginning_of_month..date.end_of_month) }
	scope :kindconsultant, -> { where("kind='輔導'")}
	scope :kindaudit, -> { where("kind='稽核'")}
	belongs_to :customer 
	has_many :consultants, dependent: :destroy
	accepts_nested_attributes_for :consultants, :allow_destroy => true
	#, :reject_if => lambda { |a| a[:content].blank? }
	has_many :audits, dependent: :destroy

	accepts_nested_attributes_for :audits, :allow_destroy => true
    #, :reject_if => lambda { |a| a[:content].blank? }
    has_and_belongs_to_many :services

	has_and_belongs_to_many :items
	has_many :items_projects

	has_attached_file :contract#,
	    # :styles => { :small =>"50x50",:medium => "300x300>", :thumb => "100x100>" },
    	#:default_url => "/images/:style/missing.png"
	 					#:path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
	 do_not_validate_attachment_file_type :contract

	#has_and_belongs_to_many :tags , through: :customers

  	
	def self.to_csv(options = {})

		head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join() # 加入BOM，解決excel中文亂碼
		csv_string = CSV.generate(csv = head) do |csv|
			 # CSV.generate(options) do |csv|
			csv << column_names
			all.each do |project|
		    	csv << project.attributes.values_at(*column_names)
			end
		end
		#csv_string.force_encoding('big5')
	end



	def self.import(file)

  
				 CSV.foreach(file.path, headers: true, encoding:'Big5:utf-8') do |row|

				 	customer= Customer.where(:customer_chi => row[0])
				 	
				 	if customer.count != 0

					    project_data = {
					      customer_id: customer.first.id,
					      project_manager: row["project_manager"],
					      total_amount: row["total_amount"],
					      currency: row["currency"],
					      project_type: row["project_type"],
					      contract_start_date: row["contract_start_date"],
					      updated_at: Time.zone.now.to_s(:db)


					    }

				 	
				 			Project.create!(project_data)
				 		end	
				 		 #sql = "delete #{table} SET #{sql_values.join(', ')} WHERE #{sql_where.join(' AND ')};"
	  #db.exec_update(sql)
						#Project.delete(108)
				  end
				
	end



end
