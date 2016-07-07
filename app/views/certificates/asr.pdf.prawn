require "prawn/measurement_extensions"
require "prawn/table"
require "prawn"
pdf = Prawn::Document.new(:page_size => "A4", page_layout: :landscape,:margin => [0, 0, 0, 0]) do
end

pdf.font ("#{Prawn::BASEDIR}/data/fonts/kaiu.ttf")
pdf.bounding_box([2.75.cm ,17.65.cm  ], :width => 23.9.cm ,:height => 2.2.cm) do
	pdf.font_size (22){
	pdf.text "皇家國際驗證有限公司\n #{@date.strftime("%Y年%m月")}請款單",:align => :center,:valign =>:center
	pdf.stroke_bounds
	}
end
		

pdf.bounding_box([2.75.cm ,14.65.cm  ], :width => 23.9.cm ,:height => 2.2.cm) do
	pdf.font_size (14){
	pdf.text "致台灣亞瑟國際驗證股份有限公司\n代表人: 葉經理峙輝  先生"
	
	}
end
		

 #[['#', 'Name', 'Price']] +
  #    @products.map do |product|
   #   [product.id, product.name, product.price]
   # end


   data = [['項次', '日期', '客戶名稱','驗證標準','證書費','5%(稅金)','其他','合計']]
   i=0
   total_amount=0
   money=0
    data+= @certificates.map do |c|
    	i=i+1
    	if c.audit.service.alias == "QC" || c.audit.service.alias == "EC" || c.audit.service.alias == "HC"
    		money=7000
    	elsif c.audit.service.alias == "GMP"
    		money=6000
    	elsif c.audit.service.alias == "FS"
    		money=12000
    	end

    	total_amount=total_amount+money
    	[i,c.audit.certificate_send_date,c.audit.project.customer.customer_chi,c.audit.service.name.split(":").first, number_to_currency(money, :precision => 0),number_to_currency(money*0.05, :precision => 0),"",number_to_currency(money*1.05, :precision => 0)]
   end
data+= [["總計","","","", number_to_currency(total_amount, :precision => 0),number_to_currency(total_amount*0.05, :precision => 0),"",number_to_currency(total_amount*1.05, :precision => 0)]]


pdf.bounding_box([2.75.cm ,13.5.cm  ], :width => 23.9.cm ) do
	pdf.font_size (14){
	
			pdf.table(data,:width => 23.9.cm , :row_colors => ["F0F0F0", "FFFFCC"] ,:cell_style => { :overflow => :shrink_to_fit, :min_font_size => 8 }
)
	}
end