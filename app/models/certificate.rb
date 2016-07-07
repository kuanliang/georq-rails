class Certificate < ActiveRecord::Base
	require "prawn/measurement_extensions"

		require "prawn"
#scope :expiration_selected_month, ->(date){ where(:expiration_date => date.beginning_of_month..date.end_of_month) or where(:expiration_date => (date+1.year).beginning_of_month..(date+1.year).end_of_month)or where(:expiration_date => (date+2.year).beginning_of_month..(date+2.year).end_of_month)}
scope :expiration_selected_month, ->(date){ where(:expiration_date => date.beginning_of_month..date.end_of_month).order(:expiration_date) }

scope :expiration_selected_this_month,-> (date){where( (:expiration_date).month.order(:expiration_date) => date.month)}	

	belongs_to :audit
	belongs_to :customer


 paginates_per 20


 		def self.to_csv(options = {})

			head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join() # 加入BOM，解決excel中文亂碼
			csv_string = CSV.generate(csv = head) do |csv|
				 # CSV.generate(options) do |csv|
				csv << column_names
				#csv << ["證書寄送日","a"]
				all.each do |certificate|
			    	csv << certificate.attributes.values_at(*column_names)
			    	#csv << certificate.audit.certificate_send_date
 				end
			end
			#csv_string.force_encoding('big5')
		end



	


end
