class Customer < ActiveRecord::Base
	 require 'csv'
	 #require 'roo'
	 #attr_accessible  :customer_num, :customer_chi,:customer_eng,:owner,:contact_tel,:contact_email,:identification_num
 
	 #accessible_attributes :customer_num, :customer_chi,:customer_eng,:owner,:contact_tel,:contact_email,:identification_num
	 paginates_per 5
	 scope :orderbycustomer, -> { order("customer_num DESC") }
	 #scope :active, where.not(:stop => true)
	 #validates :customer_num, presence: true
	 has_many :projects, dependent: :destroy
	 accepts_nested_attributes_for :projects, :allow_destroy => true
	 #, :reject_if => lambda { |a| a[:customer_num].blank? }
	 has_and_belongs_to_many :tags
     has_and_belongs_to_many :audit_months
	 has_many :customers_tags
	 has_many :audits , through: :projects
	 has_many :certificates , through: :audits
	 #scope :selected_tag, ->(tag){ where(:{tag.tag_name} => tag) }
	 	 has_many :audit_months_customers
	 
		def self.to_csv(options = {})

			head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join() # 加入BOM，解決excel中文亂碼
			csv_string = CSV.generate(csv = head) do |csv|
				 # CSV.generate(options) do |csv|
				csv << column_names
				all.each do |customer|
			    	csv << customer.attributes.values_at(*column_names)
				end
			end
			#csv_string.force_encoding('big5')
		end
		#params.require(:customer).permit(:customer_num, :customer_chi,:customer_eng,:owner,:contact_tel,:contact_email,:identification_num,  {:tag_ids => []})
 	def update_sql(table, values, condition)
	  sql_values = values.map { |col, value| "#{col} = #{db.quote(value)}" }
	  sql_where = condition.map { |col, value| "#{col} = #{db.quote(value)}" }
	  sql = "UPDATE #{table} SET #{sql_values.join(', ')} WHERE #{sql_where.join(' AND ')};"
	  db.exec_update(sql)
	  #Customer.destroy_all # Only necessary if you want to trigger callbacks.
	  #ActiveRecord::Base.connection.execute("TRUNCATE customers RESTART IDENTITY;")
	  #db.execute("TRUNCATE TABLE #{customers}")
	  
	end

	def self.insert_sql(table, values)
		bb=SQLite3::Database.new(':memory:')
	  sql_values = values.map { |col, value| "#{col} = #{db.quote(value)}" }
	  #sql_where = condition.map { |col, value| "#{col} = #{db.quote(value)}" }
	  #sql = "INSERT INTO #{table} SET #{sql_values.join(', ')};"
	  #sql = "INSERT INTO customers SET customer_num = 1;"
	  sql = "insert into customers SET customer_num='1234';"
	  #sql = "UPDATE customers SET customer_chi = '1234561222111' where customer_num='1234561111';"
 	#	sql = "insert into customers  ('1234','1234','1234','1234','1234','1234');"	
	  #db.execute(sql)
	  #sql = "INSERT INTO customers (id,customer_num) values(76',1234');"
	  #db.exec_insert(sql)
	  Customer.destroy_all
	   bb.execute (sql)
	end


def db
  ActiveRecord::Base.connection
end



			def self.import(file)

				 CSV.foreach(file.path, headers: true, encoding:'Big5:utf-8') do |row|
				 	customer = Customer.where(:customer_num => row["customer_num"]).first
					#customer_id = row["customer_num"]#get_customer_id(row[ID]) || create_customer_from_row(row)
					    customer_data = {
					      #customer_num: row["customer_num"],
					      #identification_num: row["identification_num"],
					      #customer_chi: row["customer_chi"],
					      #customer_eng: row["customer_eng"],
					      #owner: row["owner"],
					      #staff_num: row["staff_num"],
					      #site_num: row["site_num"],
					      #mr_chi: row["mr_chi"],
					      #mr_eng: row["mr_eng"],
					      #mr_pos: row["mr_pos"],
					      #fax_num: row["fax_num"],
					      #contact_tel: row["contact_tel"],
					      #contact_email: row["contact_email"],
					      #contact_ppl: row["contact_ppl"],
					      #contact_email: row["contact_email"],
					      #contact_ppl: row["contact_ppl"],
					      #contact_addr: row["contact_addr"],
					      #office_addr_chi: row["office_addr_chi"],
					      #office_addr_eng: row["office_addr_eng"],
					      #factory_addr_cht: row["factory_addr_cht"],
					      #factory_addr_eng: row["factory_addr_eng"],
					      #level: row["level"],
					      #comment: row["comment"],
					      #CB_number: row["CB_number"],
					      #certification_body: row["certification_body"],
					      #audit_standard: row["audit_standard"],
					      #scope_chi: row["scope_chi"],
					      #scope_eng: row["scope_eng"],
					      #updated_at: Time.zone.now.to_s(:db)
					      #id: customer,
					      audit_month_ids: [row["audit_month"]]

					    }
					    customer.update(customer_data)
					    #Project.delete(109)
					    #Audit.delete(Audit.last) 
					    #救命專用	
				 	#if customer.count == 1
				 	#	
					 #   update_sql('customers', customer_data, id: customer_id)
				 	#else
				 	#	customer_hash = row.to_hash
				 	#	customer_hash = customer_hash.delete("id")
				 	#	Customer.create!(customer_data)	
					    #insert_sql('customers', customer_data)
					#end
				  end
				
	  		end
	if false	
		def self.updateall()
			customers= Customer.all
			customers.each do |c|
				
				if c.stop==true
					c.stop = true
				else
					c.stop=false
				end
				customer_data={
								id: c.id,
								stop: c.stop 			
				}
				c.update(customer_data)
			end
		end
	end
	def self.updateall()
		audits= Audit.all
		audits.each do |a|
			if a.project.contract_start_date
				if a.project.contract_start_date.year <2016
					audit_data={
								id: a.id,
								status: "已完成(顧客確認)" 			
						}
						a.update(audit_data)
				else
					if a.certificate_send_date
						audit_data={
								id: a.id,
								status: "已完成(顧客確認)" 			
						}
						a.update(audit_data)
					else
						if a.certificate_get_date
								audit_data={
									id: a.id,
									status: "報告審核通過，取得證書" 			
							}
							a.update(audit_data)
						else
							if a.report_send_date

								audit_data={
									id: a.id,
									status: "報告審核中" 			
								}
								a.update(audit_data)
							else
								if a.report_get_date

									audit_data={
										id: a.id,
										status: "報告撰寫中" 			
									}
									a.update(audit_data)
								end
							end
						end
					end
				end
			

			end
		end
	end
	def continueproject()
		project=projects.where("project_type LIKE ? or project_type LIKE ?","換證續評","輔導+正評").order(contract_start_date: :desc).first
		
		if project.contract_start_date
			constract_date = (project.contract_start_date.year+1).to_s+"/"+project.contract_start_date.strftime("%m/%d").to_s
		else
			constract_date = Time.zone.now.to_s(:db)
		end
		project_data={
						customer_id: id,
						project_type: "換證續評",
						total_amount: project.total_amount,
						currency: project.currency,
						contract_start_date: constract_date,
			        	comment: "測試資料 按鈕新增"+Time.zone.now.to_s(:db)+(project.contract_start_date.year+1).to_s,
			        	partyb: project.partyb,
			        	project_manager: project.project_manager,
			        	item_ids: project.item_ids,
			        	service_ids: project.service_ids
			        }
				 		#Customer.create!(customer_data)	
		  # params.require(:project).permit(port_get_date,:comment, {:item_ids => []}, {:service_ids => []})
  
				 	Project.create!(project_data)
		
		newproject=projects.last		 	
		audits=project.audits

		audits.each do |a|
		
				if (a.service.alias =="")
					audit_type="RA"
				else	
					if a.audit_type =="正評"
						audit_type="SV1"
					elsif a.audit_type =="SV1"
						audit_type="SV2"
					elsif a.audit_type =="SV2"
						audit_type="RA"
					elsif a.audit_type =="RA"
						audit_type="SV1"	
					end
				end
				name = a.service.alias.to_s+"-"+audit_type+"-"+(newproject.contract_start_date.year).to_s
					audit_data = {
									project_id: newproject.id,
									parent_audit_id: a.id,
									real_auditor: a.real_auditor,
									service_id: a.service_id,
									certification_body: a.certification_body,
									CB_number: a.CB_number,
									audit_type: audit_type,
						            EA_CODE: a.EA_CODE,
						            ISO9000_exclusions: a.ISO9000_exclusions,
						            scope_chi: a.scope_chi,
						            scope_eng: a.scope_eng,
						            address1_chi: a.address1_chi,
						            address1_eng: a.address1_eng,
									address2_chi: a.address2_chi,
						            address2_eng: a.address2_eng,
						            address3_chi: a.address3_chi,
						            address3_eng: a.address3_eng,
						            address4_chi: a.address4_chi,
						            address4_eng: a.address4_eng,
						            audit_name: name

								}
				if newproject.id.to_i > 0
 					Audit.create!(audit_data)
   				end	
		end					



	end

end
