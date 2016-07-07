require "prawn/measurement_extensions"

require "prawn"

pdf = Prawn::Document.new(:page_size => "A4",:margin => [0, 0, 0, 0]) do
end
a=0

if (@preview=='1')

	bg = "app/assets/images/bg.jpg" 
	pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm
end
iaff = 1
if @iaf
	iaff = @iaf.to_f
end


if (@certificate.certificate_type == '認證')
	if iaff == 0
	
		manager = "app/assets/images/manager.jpg" 
	    pdf.image manager, :at => [1.6.cm,5.cm], :width => 4.7.cm 


		#iaf = "app/assets/images/iaf.jpg" 
	    #pdf.image iaf, :at => [7.0.cm,5.cm], :width => 2.8.cm

		dakks = "app/assets/images/dakks2.jpg" 
	    pdf.image dakks, :at => [7.5.cm,5.cm], :width => 5.cm 

	else
		manager = "app/assets/images/manager.jpg" 
	    pdf.image manager, :at => [1.6.cm,5.cm], :width => 4.7.cm 


		iaf = "app/assets/images/iaf.jpg" 
	    pdf.image iaf, :at => [7.0.cm,5.cm], :width => 2.8.cm

		dakks = "app/assets/images/dakks2.jpg" 
	    pdf.image dakks, :at => [10.0.cm,5.cm], :width => 4.5.cm 
	end
 
else
	
		manager = "app/assets/images/manager.jpg" 
	    pdf.image manager, :at => [1.6.cm,5.cm], :width => 4.7.cm  

	    royalcert = "app/assets/images/royalcert.jpg" 
	    pdf.image royalcert, :at => [8.3.cm,5.5.cm], :width => 4.cm 

end


pdf.font "#{Prawn::BASEDIR}/data/fonts/Candara.ttf"

if @ver=="VN"
		pdf.bounding_box([2.75.cm ,21.65.cm  ], :width => 15.6.cm ,:height => 1.cm) do
			pdf.font_size (10){pdf.text 'Royalcert chứng thực rằng hệ thống quản lý của tổ chức đã được kiểm tra xem xét và được chứng nhận thoản mãn, phù hợp với những tiêu chuẩn liên quan.',:align => :center
			if a==1
			pdf.stroke_bounds
			end
			}
		end

else
		pdf.bounding_box([2.75.cm ,21.65.cm  ], :width => 15.6.cm ,:height => 1.cm) do
			pdf.font_size (10){pdf.text 'Royalcert, certifies that the management system of the organization has been assessed and found to be in accordance with the requirements of the related standard',:align => :center
			if a==1
			pdf.stroke_bounds
			end
			}
		end
end


pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
pdf.bounding_box([2.75.cm ,20.cm  ], :width => 15.6.cm ,:height => 1.cm,:style =>[:italic]) do
	pdf.font_size (20){
	pdf.formatted_text [{:text=> @audit.service.name,:align =>:center}],:align =>:center
	if a==1
	pdf.stroke_bounds
	end
	}
end

addr_w = 15 
scope_w = 15.6 
name_w=15
addr_h = 0 
scope_h = 0 
name_h=0

if @addr_w.to_f > 0
	addr_w = @addr_w.to_f
end
if @scope_w.to_f > 0
	scope_w = @scope_w.to_f
end
if @name_w.to_f > 0
	name_w = @name_w.to_f
end


if @addr_h.to_f != 0
	addr_h = @addr_h.to_f
end
if @scope_h.to_f != 0
	scope_h = @scope_h.to_f
end
if @name_h.to_f != 0
	name_h = @name_h.to_f
end






pdf.bounding_box([(2.75+(15.6-name_w)/2).cm ,(18+name_h).cm  ], :width => name_w.cm ,:height => 3.cm,:style => :normal) do

	if @ver=="chi"
		pdf.font ("#{Prawn::BASEDIR}/data/fonts/dftk9.ttf")
		pdf.font_size (22){
		pdf.text "#{@customer.customer_chi}",:align =>:center,:valign => :center,:overflow => :shrink_to_fit
		if a==1
			pdf.stroke_bounds
		end
		}
	elsif @ver=="en"
		pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf",  :styles => [:bold]
		pdf.font_size (22){
		pdf.text_box @customer.customer_eng,:align =>:center,:valign => :center,:overflow => :shrink_to_fit
		if a==1
		pdf.stroke_bounds
		end
			}
	elsif @ver=="VN"
		pdf.font ("#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf")
		pdf.font_size (22){
		pdf.text "#{@customer.customer_chi}",:align =>:center,:valign => :center,:overflow => :shrink_to_fit
		if a==1
			pdf.stroke_bounds
		end
		}
	end	

end



if @ver == "chi" || @ver =="VN"
	addr = @audit.address1_chi
	if @audit.address2_chi!= ""


		addr = addr+"\n"+@audit.address2_chi.to_s
	end
	if @audit.address3_chi!= ""


		addr = addr+"\n"+@audit.address3_chi.to_s
	end
	if @audit.address4_chi!= ""


		addr = addr+"\n"+@audit.address4_chi.to_s
	end
end


if @ver == "en"
	addr = @audit.address1_eng
	if @audit.address2_eng != ""
		addr = addr+"\n"+@audit.address2_eng.to_s
	end
	if @audit.address3_eng != ""
		addr = addr+"\n"+@audit.address3_eng.to_s
	end
	if @audit.address4_eng != ""
		addr = addr+"\n"+@audit.address4_eng.to_s
	end
end



pdf.bounding_box([(2.75+(15.6-addr_w)/2).cm ,(15.7+addr_h).cm  ], :width => addr_w.cm ,:height => 2.cm) do
	
	if @ver=="chi"
		pdf.font_size (14){
		pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf", :style => :normal
		pdf.text addr,:align =>:center,:overflow => :shrink_to_fit,:valign => :center,:align => :center
		if a==1
			pdf.stroke_bounds
		end
		}
	elsif @ver=="en"
		pdf.font_size (13){
		pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHIC.ttf"
		pdf.text addr,:align =>:center,:overflow => :shrink_to_fit,:bold=>:false,:valign => :center,:align => :center
		if a==1
			pdf.stroke_bounds
		end
		}
	elsif @ver=="VN"
		pdf.font_size (13){
		pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHIC.ttf"
		pdf.text addr,:align =>:center,:overflow => :shrink_to_fit,:bold=>:false,:valign => :center,:align => :center
		if a==1
			pdf.stroke_bounds
		end
		}
	end


end

if @ver=="VN"
	pdf.bounding_box([2.75.cm ,13.0.cm  ], :width => 15.6.cm ,:height => 1.cm) do
		pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.TTF"
		pdf.font_size (14){
		pdf.text "Phạm vi",:align =>:center,:valign => :center
		if a==1
		pdf.stroke_bounds
		end
		}
	end
else
	pdf.bounding_box([2.75.cm ,13.0.cm  ], :width => 15.6.cm ,:height => 1.cm) do
		pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
		pdf.font_size (14){
		pdf.text "Scope",:align =>:center,:valign => :center
		if a==1
		pdf.stroke_bounds
		end
		}
	end
end
scope = @audit.scope_chi
if @audit.scope_chi.include?("。")
	scope = scope.split("。").first
else
	
	scope = @audit.scope_chi
end

pdf.bounding_box([(2.75+(15.6-scope_w)/2).cm ,(11.9+scope_h).cm  ], :width => scope_w.cm, :height=>2.5.cm ) do
	if @ver=="chi"
		pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf", :style => :normal
		pdf.font_size (14){
		pdf.text scope.to_s,:align =>:center,:overflow => :shrink_to_fit
		if a==1
	pdf.stroke_bounds
	end
		}
	else
		pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHIC.ttf", :style => :normal
		pdf.font_size (14){
		pdf.text @audit.scope_eng,:align =>:center,:overflow => :shrink_to_fit
		if a==1
	pdf.stroke_bounds
	end
		}
	end
end

pdf.bounding_box([2.6.cm ,8.9.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	pdf.text "Certification No",:bold=>:true
	if a==1
	pdf.stroke_bounds
	end
	}
end
pdf.bounding_box([7.2.cm ,8.9.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	pdf.text ": "+@certificate.certificate_num.to_s,:bold=>:true
	if a==1
	pdf.stroke_bounds
	end

	}
end



pdf.bounding_box([2.6.cm ,8.3.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	pdf.text "Initial Certification Date",:bold=>:true
	if a==1
	pdf.stroke_bounds
	end

	}
end
pdf.bounding_box([7.2.cm ,8.3.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	if @certificate.initial_date
		pdf.text ": "+@certificate.initial_date.strftime("%d.%m.%Y").to_s,:bold=>:true
	end
	}
end


pdf.bounding_box([2.6.cm ,7.7.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	pdf.text "Issue Date",:bold=>:true

	}
end
pdf.bounding_box([7.2.cm ,7.7.cm ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	if @certificate.issue_date
		pdf.text ": "+@certificate.issue_date.strftime("%d.%m.%Y").to_s,:bold=>:true
	end
	}
end


pdf.bounding_box([2.6.cm ,7.1.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	pdf.text "Expiration Date",:bold=>:true

	}
end
pdf.bounding_box([7.2.cm ,7.1.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	if (@certificate.expiration_date)
		pdf.text ": "+@certificate.expiration_date.strftime("%d.%m.%Y").to_s,:bold=>:true
	end
	}
end


pdf.bounding_box([2.0.cm ,5.4.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
	pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
	pdf.font_size (10){
	pdf.text "Certification Manager",:bold=>:true
	}
end


#pdf.render_file "d:/example.pdf"