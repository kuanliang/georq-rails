class Audit < ActiveRecord::Base
	#validates :service_id, presence: true
	scope :near_month, -> { where(:contract_date => Time.now.beginning_of_month-30..Time.now.end_of_month+30) }
	scope :this_month, -> { where(:contract_date => Time.now.beginning_of_month..Time.now.end_of_month) }
	#scope :selected_month, ->(date){ where(:contract_date => date.beginning_of_month..date.end_of_month) }
	scope :certificate_this_month,->(date){ where(:certificate_send_date => date.beginning_of_month..date.end_of_month )}
	scope :selected_month, ->(date){ where(:real_audit_date => date.beginning_of_month..date.end_of_month+1) }
    scope :selected_month_report, ->(date){ where(:audit_opendate => date.beginning_of_month..date.end_of_month+1) }


	scope :accreditation, -> (certification_body){ where(:certification_body => certification_body).where("alias Like ? or alias LIKE ? or alias LIKE ? ","QC","FS","EC")}
	scope :nonaccreditation, -> (certification_body){ where(:certification_body => certification_body).where("alias Like ? or alias LIKE ? or alias LIKE ? or alias LIKE ? or alias LIKE ? or alias LIKE ?","13485","22716","HC","GMP","OH","SA")}
	belongs_to :project 
	belongs_to :customer
	#has_and_belongs_to_many :services 
    belongs_to :service
    #belongs_to :lead_auditor
    has_one :certificate, dependent: :destroy
    #has_many :certificates, dependent: :destroy
    accepts_nested_attributes_for :certificate, :allow_destroy => true
	#has_many :tags , through: :customer 
	#has_and_belongs_to_many :tags , through: :customers

	has_one :child_audit, class_name: "Audit",
                          foreign_key: "parent_audit_id"
 
  	belongs_to :parent_audit, class_name: "Audit"

  	has_many :small_brothers, class_name: "Audit",
                          foreign_key: "brother_audit_id"
  	belongs_to :brother_audit, class_name: "Audit"
  	paginates_per 100


  	def self.search(search)
		  if search
		  	#Audit.where()
		    find(:all, :conditions => ['audit_type LIKE ? ', "%#{search}%"])
		  else
		    where(nil)
		  end
	end
	def sendreport()
		#audit=certificate.audit
		
		audit_data = {
											      id: id,
											      report_send_date: Time.zone.now.to_s(:db)

											    }
	    update(audit_data)

		
	end
	def getreport()
		#audit=certificate.audit]

		project.audits.each do |a|
			if a.real_audit_date == real_audit_date

				#aaudit=project.audits.first
				
				audit_data = {
											      id: a.id,
											      report_get_date: Time.zone.now.to_s(:db)
											      #comment: comment+audit.id.to_s
											    }
	    		a.update(audit_data)
	    	end
		end
		
	end
	def sendcertificate()
		#audit=certificate.audit
		project.audits.each do |a|
			if a.real_audit_date == real_audit_date
					audit_data = {
											      id: a.	id,
											      certificate_send_date: Time.zone.now.to_s(:db)

											    }
	   				a.update(audit_data)
	   		end
	   	end		
		
	end
	def getcertificate()
		#audit=certificate.audit
		
		audit_data = {
											      id: id,
											      certificate_get_date: Time.zone.now.to_s(:db)

											    }
	    update(audit_data)

		
	end
	def self.to_csv(options = {})

		head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join() # 加入BOM，解決excel中文亂碼
		csv_string = CSV.generate(csv = head) do |csv|
			 # CSV.generate(options) do |csv|
			csv << column_names
			all.each do |audit|
		    	csv << audit.attributes.values_at(*column_names)
			end
		end
		#csv_string.force_encoding('big5')
	end

	def self.import(file)


		CSV.foreach(file.path, headers: true, encoding:'Big5:utf-8') do |row|

		 	customers= Customer.where('customer_chi LIKE ?', "%#{row["name"]}%")
		 	
		 		temps =row["代號"].split('-')
		 		
		 		serviceids=[]
				temps.each do |t|
				 	serviceids=serviceids+[Service.where(:alias => t).first.id]
				end	
		 		
		 		if row["操作"]=="import old"

				 	
				 	if customers.first
#row["real_audit_date"].split("/").first
						
						
						#audit_year=row["audit_year"]
						audit_year=row["real_audit_date"].split("/").first	
						projects=customers.first.projects.where('contract_start_date LIKE ?',"%#{audit_year}%")
						if(projects.count==0)		
								 project_data = {
											      customer_id: customers.first.id,
											      currency: row["currency"],
											      project_type: "換證續評",
											      contract_start_date: row["real_audit_date"],
											      updated_at: Time.zone.now.to_s(:db),
										 		  comment: Time.zone.now.to_s(:db)+"批次建立"+row["comment"].to_s,
										 		  service_ids: serviceids

											    }

										 	
										 			Project.create!(project_data)
							

						 		project=customers.first.projects.last



						 		temps.each do |t|

							
									 	if customers.count != 0 && customers.first.projects.count !=0
									 		
									 		service= Service.where(:alias => t)

												  
									 		if service.first

												     audit_data = {
												      project_id: project.id,
												      certification_body: row["certification_body"],
												      CB_number: row["CB_number"],
												      audit_type: row["audit_type"],
												      service_id: service.first.id,
												      scope_chi: customers.first.scope_chi,
												      scope_eng: customers.first.scope_eng,
												      address1_chi: customers.first.office_addr_chi,
												      address1_eng: customers.first.office_addr_eng,
												      real_audit_date: row["real_audit_date"],
												      updated_at: Time.zone.now.to_s(:db),
												      status: row["status"],
												      audit_name: t.to_s+"-"+row["audit_type"].to_s+audit_year,
												      real_auditor: row["real_auditor"]
												    }
#如果已經有舊資料
												if project.audits.where(:service_id => service.first.id).count != 0
									 				
														audit=project.audits.where(:service_id => service.first.id).last
														audit.update(audit_data)

														certificate_data={
											 				audit_id: audit.id,
															expiration_date: row["expiration_date"]
											 			
											 			}

											 			if audit.certificate
											 				audit.certificate.update(certificate_data)
											 			else

											 				Certificate.create!(certificate_data)
											 			end

									 			else
											 	
											 			Audit.create!(audit_data)
											 			audit=project.audits.last

											 			certificate_data={
											 				audit_id: audit.id,
															expiration_date: row["expiration_date"]


											 			
											 			}
											 		Certificate.create!(certificate_data)
											 	end
											 end

									 	end	
								end
								#end of temps
							end
					end
					#END OF customers.first

				elsif row["操作"]=="import new"
					if customers.first
								 project_data = {
											      customer_id: customers.first.id,
											      currency: row["currency"],
											      project_type: "換證續評",
											      contract_start_date: row["real_audit_date"],
											      updated_at: Time.zone.now.to_s(:db),
										 		  comment: Time.zone.now.to_s(:db)+"批次建立",
										 		  service_ids: serviceids

											    }

										 	
										 			Project.create!(project_data)

						 		project=customers.first.projects.last

						 		temps.each do |t|

							
									 	if customers.count != 0 && customers.first.projects.count !=0
									 		
									 		service= Service.where(:alias => t)

												  
									 		if service.first

												     audit_data = {
												      project_id: project.id,
												      certification_body: row["certification_body"],
												      CB_number: row["CB_number"],
												      audit_type: row["audit_type"],
												      service_id: service.first.id,
												      scope_chi: customers.first.scope_chi,
												      scope_eng: customers.first.scope_eng,
												      address1_chi: customers.first.office_addr_chi,
												      address1_eng: customers.first.office_addr_eng,
												      real_audit_date: row["real_audit_date"],
												      updated_at: Time.zone.now.to_s(:db),
												      status: row["status"],
												      audit_name: t.to_s+"-"+row["audit_type"],
												      real_auditor: row["real_auditor"]
												    }
#如果已經有舊資料
												if project.audits.where(:service_id => service.first.id).count != 0
									 				
														audit=project.audits.where(:service_id => service.first.id).last
														audit.update(audit_data)

														certificate_data={
											 				audit_id: audit.id,
															expiration_date: row["expiration_date"]
											 			
											 			}

											 			if audit.certificate
											 				audit.certificate.update(certificate_data)
											 			else

											 				Certificate.create!(certificate_data)
											 			end

									 			else
											 	
											 			Audit.create!(audit_data)
											 			audit=project.audits.last

											 			certificate_data={
											 				audit_id: audit.id,
															expiration_date: row["expiration_date"]


											 			
											 			}
											 		Certificate.create!(certificate_data)
											 	end
											 end

									 	end	
								end
								#end of temps



					end
				end
				#END OF row["操作"]=="import old"

		end
				
	end

end

