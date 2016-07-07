
require "prawn/measurement_extensions"

require "prawn"




if @type == "IRCA"
	pdf = Prawn::Document.new(:page_size => "A4",:margin => [0, 0, 0, 0],:page_layout => :landscape) do
	end
else
	pdf = Prawn::Document.new(:page_size => "A4",:margin => [0, 0, 0, 0]) do
	end
end
audit_team=[]

days = 0
if @audit.audit_closedate && @audit.audit_opendate

	days=@audit.audit_closedate.day - @audit.audit_opendate.day+1
end

if @audit.lead_auditor !=""
	audit_team=audit_team+[@audit.lead_auditor]
end
if @audit.auditor !=""
	audit_team=audit_team+[@audit.auditor]
end
if @audit.auditor2 !=""
	audit_team=audit_team+[@audit.auditor2]
end



services= []
standard= @audit.service.name
audit_type = @audit.audit_type

if @audit.brother_audit
	@audit.brother_audit.small_brothers.each do|a|
		services = services+[a.service.name]
	end
end
if services.include?(@audit.service.name)
else	
	services= services+[@audit.service.name]
end

#standards=services

if services.include?("ISO 22000:2005")&&services.include?("HACCP") && (@audit.service.name == "ISO 22000:2005"||@audit.service.name == "HACCP")
	
	standard="ISO 22000:2005/HACCP"
end


#if services.include?("ISO 9001:2015")&&services.include?("ISO 14000")
#	STANDARD=["ISO 22000:2005/HACCP"]
#end

audit_type=""
if @audit.audit_type=="SG-stg1"
	
	audit_type="Certification Stage-1 Audit"

elsif @audit.audit_type=="SG-stg2"
	audit_type="Certification Stage-2 Audit"
elsif @audit.audit_type=="SV1"	
	audit_type="Surveillance-1 Audit"
elsif @audit.audit_type=="SV2"	
	audit_type="Surveillance-2 Audit"
elsif @audit.audit_type=="RA"	
end

#if audit.small_brothers.include(22000)
prepare_audit_date=""
prepare_audit_date_day=""
prepare_audit_date_month=""
prepare_audit_date_year=""
audit_date=""
audit_date_day=""
audit_date_month=""
audit_date_year=""
//ss
if @audit.prepare_opendate && @audit.prepare_closedate
	if @audit.prepare_opendate.strftime("%m").to_s!=@audit.prepare_closedate.strftime("%m").to_s
		prepare_audit_date="#{@audit.prepare_opendate.strftime("%d.%m.%Y")}-#{@audit.prepare_closedate.strftime("%d.%m.%Y")}"
	else
		if @audit.prepare_opendate.strftime("%d")!=@audit.prepare_closedate.strftime("%d")
			prepare_audit_date_day="#{@audit.prepare_opendate.strftime("%d")}-#{@audit.prepare_closedate.strftime("%d")}"
			prepare_audit_date=prepare_audit_date_day+@audit.prepare_opendate.strftime(".%m.%Y")
		else
			prepare_audit_date=@audit.prepare_opendate.strftime("%d.%m.%Y")
		end
	end
end

if @audit.audit_opendate && @audit.audit_closedate
	if @audit.audit_opendate.strftime("%m").to_s!=@audit.audit_closedate.strftime("%m").to_s
		audit_date="#{@audit.audit_opendate.strftime("%d.%m.%Y")}-#{@audit.audit_closedate.strftime("%d.%m.%Y")}"
	else
		if @audit.audit_opendate.strftime("%d")!=@audit.audit_closedate.strftime("%d")
			audit_date_day="#{@audit.audit_opendate.strftime("%d")}-#{@audit.audit_closedate.strftime("%d")}"
			audit_date=audit_date_day+@audit.audit_opendate.strftime(".%m.%Y")
		else
			audit_date=@audit.audit_opendate.strftime("%d.%m.%Y")
		end
	end

end

audit_standard=@audit.service.name



if @type == "Form01"
	
	bg = "app/assets/images/formbg/#{@type}.jpeg" 
	pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm


pdf.font "#{Prawn::BASEDIR}/data/fonts/verdana.ttf"
	pdf.bounding_box([7.1.cm ,25.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true
		}
	end
	#pdf.bounding_box([7.1.cm ,25.cm  ], :width => 16.cm ,:height => 1.cm) do
	#	pdf.font_size (10){pdf.text "#{services.join(",")}",:align => :left,:inline_format => true
	#	}
	#end
	pdf.bounding_box([7.1.cm ,23.2.cm  ], :width => 13.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.office_addr_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end
	pdf.bounding_box([7.1.cm ,20.65.cm  ], :width => 13.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.contact_tel}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([7.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.fax_num}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([7.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.mr_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([15.7.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.mr_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end
	pdf.bounding_box([7.1.cm ,17.6.cm  ], :width => 13.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.staff_num}",:align => :left,:inline_format => true,:valign => :center
		}
	end
	pdf.bounding_box([17.4.cm ,17.6.cm  ], :width => 13.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.site_num}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([2.8.cm ,14.9.cm  ], :width => 10.7.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.office_addr_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([13.8.cm ,14.9.cm  ], :width => 10.7.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.staff_num}",:align => :left,:inline_format => true,:valign => :center
		}
	end
	pdf.bounding_box([17.cm ,14.9.cm  ], :width => 10.7.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.try(:shift_num)}",:align => :left,:inline_format => true,:valign => :center
		}
	end

pdf.line_width = 1
	if @audit.audit_type=="SG-stg1" || @audit.audit_type=="SG-stg2"
		pdf.fill_rectangle [2.8.cm,8.36.cm],9,9
		pdf.stroke_rectangle [7.08.cm,8.36.cm],9,9
		pdf.stroke_rectangle [11.44.cm,8.36.cm],9,9
		pdf.stroke_rectangle [15.8.cm,8.36.cm],9,9


	elsif @audit.audit_type=="SV1" || @audit.audit_type=="SV2" || @audit.audit_type=="RA"
		pdf.stroke_rectangle [2.8.cm,8.36.cm],9,9
		pdf.fill_rectangle [7.08.cm,8.36.cm],9,9
		pdf.stroke_rectangle [11.44.cm,8.36.cm],9,9
		pdf.stroke_rectangle [15.8.cm,8.36.cm],9,9
		if @audit.audit_type=="SV1"
			pdf.bounding_box([7.08.cm ,7.8.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (10){pdf.text "(1.Surveillance)",:align => :left,:inline_format => true
			}
			end

		elsif @audit.audit_type=="SV2"
			pdf.bounding_box([7.08.cm ,7.8.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (10){pdf.text "(2.Surveillance)",:align => :left,:inline_format => true
			}
			end

		end
		
	else 
	end


show = [ "ISO 9001:2008","ISO 9001:2015","ISO 14001:2008","ISO 14000:2015","ISO 22000:2005","OHSAS 18001:2007","ISO 13485:2012"]


	if services.include?("ISO 9001:2008")
		pdf.bounding_box([3.8.cm ,5.9.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (7.6){pdf.text "ISO 9001:2008",:align => :left,:inline_format => true,:valign => :center
			}
		end
		#pdf.bounding_box([3.8.cm ,5.1.cm  ], :width => 10.7.cm ,:height => 1.cm) do
		#	pdf.font_size (7.6){pdf.text "ISO 14001:2015",:align => :left,:inline_format => true,:valign => :center
		#	}
		#end
		pdf.fill_rectangle [2.9.cm,5.56.cm],9,9
		pdf.stroke_rectangle [2.9.cm,4.78.cm],9,9
		pdf.stroke_rectangle [2.9.cm,4.0.cm],9,9
		pdf.stroke_rectangle [11.49.cm,5.56.cm],9,9
		pdf.stroke_rectangle [11.49.cm,4.78.cm],9,9
		pdf.stroke_rectangle [11.49.cm,4.0.cm],9,9

	elsif services.include?("ISO 9001:2015")
		pdf.bounding_box([3.8.cm ,5.9.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (7.6){pdf.text "ISO 9001:2015",:align => :left,:inline_format => true,:valign => :center
			}
		end
		#pdf.bounding_box([3.8.cm ,5.1.cm  ], :width => 10.7.cm ,:height => 1.cm) do
		#	pdf.font_size (7.6){pdf.text "ISO 14001:2015",:align => :left,:inline_format => true,:valign => :center
		#	}
		#end
		pdf.fill_rectangle [2.9.cm,5.56.cm],9,9
		pdf.stroke_rectangle [2.9.cm,4.78.cm],9,9
		pdf.stroke_rectangle [2.9.cm,4.0.cm],9,9
		pdf.stroke_rectangle [11.49.cm,5.56.cm],9,9
		pdf.stroke_rectangle [11.49.cm,4.78.cm],9,9
		pdf.stroke_rectangle [11.49.cm,4.0.cm],9,9
	else
		pdf.bounding_box([3.8.cm ,5.9.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (7.6){pdf.text "ISO 9001:2015",:align => :left,:inline_format => true,:valign => :center
			}
		end
	end


	if services.include?("ISO 14001:2008")
		#pdf.bounding_box([3.8.cm ,5.9.cm  ], :width => 10.7.cm ,:height => 1.cm) do
		#	pdf.font_size (7.6){pdf.text "ISO 9001:2008",:align => :left,:inline_format => true,:valign => :center
		#	}
		#end
		pdf.bounding_box([3.8.cm ,5.1.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (7.6){pdf.text "ISO 14001:2008",:align => :left,:inline_format => true,:valign => :center
			}
		end
		pdf.stroke_rectangle [2.9.cm,5.56.cm],9,9
		pdf.fill_rectangle [2.9.cm,4.78.cm],9,9
		pdf.stroke_rectangle [2.9.cm,4.0.cm],9,9
		pdf.stroke_rectangle [11.49.cm,5.56.cm],9,9
		pdf.stroke_rectangle [11.49.cm,4.78.cm],9,9
		pdf.stroke_rectangle [11.49.cm,4.0.cm],9,9

	elsif services.include?("ISO 14000:2015")
	
		#pdf.bounding_box([3.8.cm ,5.9.cm  ], :width => 10.7.cm ,:height => 1.cm) do
		#	pdf.font_size (7.6){pdf.text "ISO 9001:2008",:align => :left,:inline_format => true,:valign => :center
		#	}
		#end
		pdf.bounding_box([3.8.cm ,5.1.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (7.6){pdf.text "ISO 14000:2015",:align => :left,:inline_format => true,:valign => :center
			}
		end
		pdf.stroke_rectangle [2.9.cm,5.56.cm],9,9
		pdf.fill_rectangle [2.9.cm,4.78.cm],9,9
		pdf.stroke_rectangle [2.9.cm,4.0.cm],9,9
		pdf.stroke_rectangle [11.49.cm,5.56.cm],9,9
		pdf.stroke_rectangle [11.49.cm,4.78.cm],9,9
		pdf.stroke_rectangle [11.49.cm,4.0.cm],9,9
	else
		pdf.bounding_box([3.8.cm ,5.1.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (7.6){pdf.text "ISO 14001:2015",:align => :left,:inline_format => true,:valign => :center
			}
		end
	end

		
		

		if services.include?("ISO 22000:2005")

			pdf.stroke_rectangle [2.9.cm,5.56.cm],9,9
			pdf.stroke_rectangle [2.9.cm,4.78.cm],9,9
			pdf.fill_rectangle [2.9.cm,4.0.cm],9,9
			pdf.stroke_rectangle [11.49.cm,5.56.cm],9,9
			pdf.stroke_rectangle [11.49.cm,4.78.cm],9,9
			pdf.stroke_rectangle [11.49.cm,4.0.cm],9,9
		end
		if services.include?("OHSAS 18001:2007")
				pdf.stroke_rectangle [2.9.cm,5.56.cm],9,9
			pdf.stroke_rectangle [2.9.cm,4.78.cm],9,9
			pdf.stroke_rectangle [2.9.cm,4.0.cm],9,9
			pdf.fill_rectangle [11.49.cm,5.56.cm],9,9
			pdf.stroke_rectangle [11.49.cm,4.78.cm],9,9
			pdf.stroke_rectangle [11.49.cm,4.0.cm],9,9
		end
		if services.include?("ISO 13485:2012")
				pdf.stroke_rectangle [2.9.cm,5.56.cm],9,9
			pdf.stroke_rectangle [2.9.cm,4.78.cm],9,9
			pdf.stroke_rectangle [2.9.cm,4.0.cm],9,9
			pdf.stroke_rectangle [11.49.cm,5.56.cm],9,9
			pdf.fill_rectangle [11.49.cm,4.78.cm],9,9
			pdf.stroke_rectangle [11.49.cm,4.0.cm],9,9
		end

		others=[]
		services.each do |s|
			if show.include?(s)
			else
				if others.include?(s)
				else
					others=others+[s]
				end
			end
		end

		if others.empty?
		else
			pdf.stroke_rectangle [2.9.cm,5.56.cm],9,9
			pdf.stroke_rectangle [2.9.cm,4.78.cm],9,9
			pdf.stroke_rectangle [2.9.cm,4.0.cm],9,9
			pdf.stroke_rectangle [11.49.cm,5.56.cm],9,9
			pdf.stroke_rectangle [11.49.cm,4.78.cm],9,9
			pdf.fill_rectangle [11.49.cm,4.0.cm],9,9
			pdf.bounding_box([13.8.cm ,4.3.cm  ], :width => 10.7.cm ,:height => 1.cm) do
			pdf.font_size (7.6){pdf.text "#{others.join(",")}",:align => :left,:inline_format => true,:valign => :center
			}
			end
		end

	pdf.start_new_page
	

	bg = "app/assets/images/formbg/#{@type}-2.jpeg" 
	pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm

	pdf.bounding_box([3.3.cm ,19.3.cm  ], :width => 15.7.cm ,:height => 3.cm) do
			pdf.font_size (14){pdf.text "#{@audit.scope_eng}",:align => :center,:inline_format => true,:valign => :center
	}

	end
	pdf.bounding_box([6.3.cm ,16.3.cm  ], :width => 15.7.cm ,:height => 3.cm) do
			pdf.font_size (10){pdf.text "#{@audit.ISO9000_exclusions}",:align => :center,:inline_format => true,:valign => :center
	}

	end


end


if @type == "Form08"



	bg = "app/assets/images/formbg/#{@type}.jpeg" 
	pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm

	pdf.font "#{Prawn::BASEDIR}/data/fonts/verdana.ttf"
	pdf.bounding_box([6.3.cm ,25.05.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end
	
	pdf.bounding_box([6.3.cm ,24.05.cm  ], :width => 14.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.mr_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end	

	pdf.bounding_box([6.3.cm ,23.05.cm  ], :width => 14.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.address1_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end	

	pdf.bounding_box([6.3.cm ,22.05.cm  ], :width => 14.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.staff_num}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([6.3.cm ,21.05.cm  ], :width => 14.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.contact_tel}",:align => :left,:inline_format => true,:valign => :center
		}
	end
	pdf.bounding_box([14.9.cm ,21.05.cm  ], :width => 14.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.fax_num}",:align => :left,:inline_format => true,:valign => :center
		}
	end


	pdf.bounding_box([6.3.cm ,19.5.cm  ], :width => 13.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.scope_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end


	pdf.bounding_box([6.3.cm ,16.53.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{standard} #{audit_type}",:align => :left,:inline_format => true,:valign => :center
		}
	end


	pdf.bounding_box([6.3.cm ,15.5.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{audit_date}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([15.8.cm ,15.5.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.man_day}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	
	pdf.bounding_box([6.3.cm ,14.5.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.CB_number}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([3.3.cm ,10.cm  ], :width => 5.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.lead_auditor}",:align => :center,:inline_format => true,:valign => :center
		}
	end


	pdf.bounding_box([9.3.cm ,10.cm  ], :width => 5.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.auditor}\n#{@audit.auditor2}",:align => :center,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([14.3.cm ,10.cm  ], :width => 5.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.specialist}",:align => :center,:inline_format => true,:valign => :center
		}
	end
end

if @type == "Form09"



	bg = "app/assets/images/formbg/#{@type}.jpeg" 
	pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm

	pdf.font "#{Prawn::BASEDIR}/data/fonts/verdana.ttf"
	pdf.bounding_box([7.1.cm ,25.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true,:valign => :center
		}
	end
	
	pdf.bounding_box([7.1.cm ,23.95.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{prepare_audit_date}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([7.1.cm ,22.93.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{audit_type}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([7.1.cm ,21.8.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{audit_date}",:align => :left,:inline_format => true,:valign => :center
		}
	end

	pdf.bounding_box([7.1.cm ,20.8.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{standard}",:align => :left,:inline_format => true,:valign => :center
		}
	end
end

if @type == "Form10"
	if days < 4
	if @audit.service.name=="ISO 9001:2008" && days==1 
		if audit_team.count==3
			bg = "app/assets/images/formbg/#{@type}QC2008Day1Team3.jpeg" 
		
		elsif audit_team.count==2
			bg = "app/assets/images/formbg/#{@type}QC2008Day1Team2.jpeg" 
			
		elsif audit_team.count==1
			bg = "app/assets/images/formbg/#{@type}QC2008Day1Team1.jpeg" 
			
		end
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm
			pdf.bounding_box([6.1.cm ,25.2.cm  ], :width => 16.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,24.5.cm  ], :width => 16.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.address1_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,23.8.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.scope_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,23.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@customer.mr_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

				pdf.bounding_box([6.1.cm ,20.7.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{standard}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([14.5.cm ,20.7.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{audit_type}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([6.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{prepare_audit_date}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				
				pdf.bounding_box([11.7.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.man_day}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([17.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{audit_date}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([6.1.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.lead_auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([11.7.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end
				pdf.bounding_box([17.1.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.auditor2}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([6.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "",:align => :left,:inline_format => true,:valign => :center
				}
				end		
				pdf.bounding_box([11.7.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.specialist}",:align => :left,:inline_format => true,:valign => :center
				}
				end		
				pdf.bounding_box([17.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.train_auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end
				pdf.bounding_box([17.1.cm ,17.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "chinese",:align => :left,:inline_format => true,:valign => :center
				}
				end			

				pdf.bounding_box([2.7.cm ,8.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (9){pdf.text "#{@audit.audit_opendate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
			pdf.start_new_page
			if audit_team.count==3
				bg = "app/assets/images/formbg/#{@type}QC2008Day1Team3-2.jpeg" 
			elsif audit_team.count==2
				bg = "app/assets/images/formbg/#{@type}QC2008Day1Team2-2.jpeg" 
			elsif audit_team.count==1
				bg = "app/assets/images/formbg/#{@type}QC2008Day1Team1-2.jpeg" 
			
			end

		
		
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm
			pdf.bounding_box([2.7.cm ,21.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (9){pdf.text "#{@audit.audit_opendate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

	end
	if @audit.service.alias=="FS" && days==1
	 	
			bg = "app/assets/images/formbg/#{@type}#{@audit.service.alias}Day1Team#{audit_team.count.to_s}.jpeg" 
	
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm


				pdf.bounding_box([6.1.cm ,25.2.cm  ], :width => 16.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,24.5.cm  ], :width => 16.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.address1_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,23.8.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.scope_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,23.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@customer.mr_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

				pdf.bounding_box([6.1.cm ,20.7.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{standard}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([14.5.cm ,20.7.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{audit_type}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([6.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{prepare_audit_date}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				
				pdf.bounding_box([11.7.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.man_day}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([17.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{audit_date}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([6.1.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.lead_auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([11.7.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end
				pdf.bounding_box([17.1.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.auditor2}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([6.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "",:align => :left,:inline_format => true,:valign => :center
				}
				end		
				pdf.bounding_box([11.7.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.specialist}",:align => :left,:inline_format => true,:valign => :center
				}
				end		
				pdf.bounding_box([17.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.train_auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end
				pdf.bounding_box([17.1.cm ,17.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "chinese",:align => :left,:inline_format => true,:valign => :center
				}
				end			

				pdf.bounding_box([2.9.cm ,14.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (9){pdf.text "#{@audit.audit_opendate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
		elsif @audit.service.alias=="FS" && days==2
			
			bg = "app/assets/images/formbg/#{@type}#{@audit.service.alias}Day2Team#{audit_team.count.to_s}.jpeg" 
	
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm

			pdf.bounding_box([6.1.cm ,25.2.cm  ], :width => 16.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,24.5.cm  ], :width => 16.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.address1_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,23.8.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.scope_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,23.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@customer.mr_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

				pdf.bounding_box([6.1.cm ,20.7.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{standard}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([14.5.cm ,20.7.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{audit_type}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([6.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{prepare_audit_date}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				
				pdf.bounding_box([11.7.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.man_day}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([17.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{audit_date}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([6.1.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.lead_auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([11.7.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end
				pdf.bounding_box([17.1.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.auditor2}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([6.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "",:align => :left,:inline_format => true,:valign => :center
				}
				end		
				pdf.bounding_box([11.7.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.specialist}",:align => :left,:inline_format => true,:valign => :center
				}
				end		
				pdf.bounding_box([17.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.train_auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end
				pdf.bounding_box([17.1.cm ,17.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "chinese",:align => :left,:inline_format => true,:valign => :center
				}
				end			

				pdf.bounding_box([2.8.cm ,10.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (9){pdf.text "#{@audit.audit_opendate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
				}
				end		





			pdf.start_new_page
			
			bg = "app/assets/images/formbg/#{@type}#{@audit.service.alias}Day2Team#{audit_team.count.to_s}-2.jpeg" 
			
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm
			

			pdf.bounding_box([2.8.cm ,21.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (9){pdf.text "#{@audit.audit_opendate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
				}
			end

			pdf.bounding_box([2.8.cm ,9.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (9){pdf.text "#{@audit.audit_closedate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
				}
			end	
			pdf.start_new_page

			

			
			bg = "app/assets/images/formbg/#{@type}#{@audit.service.alias}Day2Team#{audit_team.count.to_s}-3.jpeg" 
			
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm

			pdf.bounding_box([2.8.cm ,22.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (9){pdf.text "#{@audit.audit_closedate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
				}
			end	
	elsif @audit.service.alias=="EC" && days==3

			
			bg = "app/assets/images/formbg/#{@type}#{@audit.service.alias}Day3Team#{audit_team.count.to_s}.jpeg" 
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm

			pdf.bounding_box([6.1.cm ,25.2.cm  ], :width => 16.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,24.5.cm  ], :width => 16.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.address1_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,23.8.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.scope_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

			pdf.bounding_box([6.1.cm ,23.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@customer.mr_eng}",:align => :left,:inline_format => true,:valign => :center
				}
				end

				pdf.bounding_box([6.1.cm ,20.7.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{standard}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([14.5.cm ,20.7.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{audit_type}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([6.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{prepare_audit_date}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				
				pdf.bounding_box([11.7.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.man_day}",:align => :left,:inline_format => true,:valign => :center
				}
				end	

				pdf.bounding_box([17.1.cm ,19.9.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{audit_date}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([6.1.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.lead_auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([11.7.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end
				pdf.bounding_box([17.1.cm ,19.2.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.auditor2}",:align => :left,:inline_format => true,:valign => :center
				}
				end	
				pdf.bounding_box([6.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "",:align => :left,:inline_format => true,:valign => :center
				}
				end		
				pdf.bounding_box([11.7.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.specialist}",:align => :left,:inline_format => true,:valign => :center
				}
				end		
				pdf.bounding_box([17.1.cm ,18.4.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "#{@audit.train_auditor}",:align => :left,:inline_format => true,:valign => :center
				}
				end
				pdf.bounding_box([17.1.cm ,17.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (10){pdf.text "chinese",:align => :left,:inline_format => true,:valign => :center
				}
				end			

				pdf.bounding_box([2.8.cm ,10.6.cm  ], :width => 13.cm ,:height => 1.cm) do
				pdf.font_size (9){pdf.text "#{@audit.audit_opendate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
				}
				end		



				pdf.bounding_box([2.8.cm ,9.6.cm  ], :width => 13.cm ,:height => 1.cm) do
					pdf.font_size (9){pdf.text "#{@audit.audit_closedate.strftime("%d.%m.%Y")}",:align => :left,:inline_format => true,:valign => :center
					}
				end	





	else
		pdf.bounding_box([2.3.cm ,15.9.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font ("#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"), :style => :bold
			pdf.font_size (13){pdf.text "稽核人數#{audit_team.count.to_s}天數#{days}輸入有問題",:bold=>:true
			}
		end
	end

else
	pdf.bounding_box([2.3.cm ,15.9.cm  ], :width => 14.6.cm ,:height => 0.5.cm) do
			pdf.font ("#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"), :style => :bold
			pdf.font_size (13){pdf.text "稽核四天以上 公司太大間 系統無法負荷",:bold=>:true
			}
		end
end

end


if @type == "Form11"
	bg = "app/assets/images/formbg/#{@type}.jpeg" 
	pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm

	pdf.bounding_box([4.8.cm ,26.85.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.CB_number}",:align => :left,:inline_format => true,:valign => :center
		}
	end

		pdf.bounding_box([9.8.cm ,26.85.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true,:valign => :center,:overflow => :shrink_to_fit
		}
	end
end


if @type == "Form13"
	bg = "app/assets/images/formbg/#{@type}.jpeg" 
	pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm


	pdf.bounding_box([4.5.cm ,25.1.cm  ], :width => 9.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true,:valign => :center,:overflow => :shrink_to_fit
		}
	end

	pdf.bounding_box([16.7.cm ,25.1.cm  ], :width => 9.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{standard}",:align => :left,:inline_format => true,:valign => :center,:overflow => :shrink_to_fit
		}
	end



	pdf.bounding_box([4.5.cm ,24.25.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.CB_number}",:align => :left,:inline_format => true,:valign => :center
		}
	end
	pdf.bounding_box([16.7.cm ,24.05.cm  ], :width => 3.8.cm ,:height => 0.6.cm) do
		pdf.font_size (10){pdf.text "#{audit_type}",:align => :left,:inline_format => true,:valign => :center,:overflow => :shrink_to_fit
		}
	end



end



if @type == "IRCA"
	bg = "app/assets/images/formbg/#{@type}.jpeg" 
	pdf.image bg, :at => [0.cm,21.cm],:width =>29.7.cm

if @audit.real_audit_date
	pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"
	pdf.bounding_box([1.5.cm ,10.2.cm  ], :width => 16.cm ,:height => 1.cm) do
		pdf.font_size (10){pdf.text "#{@audit.real_audit_date.strftime("%d/%m/%y")}",:align => :left,:inline_format => true
		}
	end
end
	
	pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"
	pdf.bounding_box([6.3.cm ,10.2.cm  ], :width => 3.9.cm) do
		pdf.font_size (10){pdf.text "#{@customer.customer_eng}",:align => :left,:inline_format => true
		}
	end
	pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"
	pdf.bounding_box([6.3.cm ,pdf.cursor  ], :width => 3.9.cm) do
		pdf.font_size (10){pdf.text "#{@customer.customer_chi}",:align => :left,:inline_format => true
		}
	end

	pdf.bounding_box([6.3.cm ,pdf.cursor-10  ], :width => 3.9.cm) do
		pdf.font_size (10){pdf.text "#{@audit.address1_eng}",:align => :left,:inline_format => true
		}
	end
	pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"
	pdf.bounding_box([6.3.cm ,pdf.cursor  ], :width => 3.9.cm) do
		pdf.font_size (10){pdf.text "#{@audit.address1_chi}",:align => :left,:inline_format => true
		}
	end
	pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"
	pdf.bounding_box([6.3.cm ,pdf.cursor-10  ], :width => 3.9.cm) do
		pdf.font_size (10){pdf.text "TEL:#{@customer.contact_tel}",:align => :left,:inline_format => true
		}
	end
	pdf.bounding_box([6.3.cm ,pdf.cursor  ], :width => 3.9.cm) do
		pdf.font_size (10){pdf.text "FAX:#{@customer.fax_num}",:align => :left,:inline_format => true
		}
	end

	pdf.bounding_box([6.3.cm ,pdf.cursor-10  ], :width => 3.9.cm) do
		pdf.font_size (10){pdf.text "MR:#{@customer.mr_eng}",:align => :left,:inline_format => true
		}
	end
	pdf.bounding_box([6.3.cm ,pdf.cursor  ], :width => 3.9.cm) do
		pdf.font_size (10){pdf.text "管理代表:#{@customer.mr_chi}",:align => :left,:inline_format => true
		}
	end

	pdf.bounding_box([14.6.cm ,10.2.cm  ], :width => 2.1.cm,:height => 0.4.cm) do
		pdf.font_size (10){pdf.text "#{standard}",:align => :left,:inline_format => true,:overflow => :shrink_to_fit
		}
	end



end


if @type == "驗證通知單"

	if @audit.real_audit_date
		pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"
		pdf.bounding_box([2.9.cm ,29.2.cm  ], :width => 16.cm ,:height => 1.cm) do
			pdf.font_size (16){pdf.text "<u>喬 治 亞 國 際 開 發 股 份 有 限 公 司 </u>",:align => :center,:inline_format => true
			}
		end

		pdf.bounding_box([2.9.cm ,28.5.cm  ], :width => 16.cm ,:height => 1.cm) do
			pdf.font_size (12){pdf.text "地址: 高雄市鳳山區鳳南路26號14樓",:align => :center
			}
		end
		pdf.bounding_box([2.9.cm ,28.cm  ], :width => 16.cm ,:height => 1.cm) do
			pdf.font_size (12){pdf.text "電話:07-3970567 傳真:07-3821767 E-mail: GICCL99@gmail.com",:align => :center
			}
		end

		pdf.stroke_horizontal_line 2.cm,18.4.cm

		#hightlight=HightlightCallback.new(:color=>'ffff00', :document => self)

		pdf.indent (70) do
			pdf.bounding_box([5.5.cm ,26.cm  ], :width => 6.0.cm ,:height => 0.6.cm,:style =>:bold) do
				pdf.font_size (15){pdf.text "驗   證   通   知   單",:align => :center
				}
				pdf.transparent(0.5) { pdf.stroke_bounds }
			end
		end	

		
		servicetext = ""
		@audit.small_brothers.each do |a|
			if a != @audit.small_brothers.first
				servicetext=servicetext+" & "
			end
			servicetext = servicetext+a.service.name
		
		end	


		expirationtext = ""

		if @audit.small_brothers.count==1  
			if @audit.parent_audit
					if @audit.parent_audit.certificate
						if @audit.parent_audit.certificate.expiration_date
							expirationtext =expirationtext+@audit.parent_audit.certificate.expiration_date.strftime("%Y/%m/%d")
							
						end
					end
			end
		else

			@audit.small_brothers.each do|a|
				if a.parent_audit
					if a.parent_audit.certificate
						if a.parent_audit.certificate.expiration_date
							expirationtext =expirationtext+a.parent_audit.certificate.expiration_date.strftime("%Y/%m/%d")+"("+a.service.name+")\n"
							
						end
					end
				end
			end
		end

		text3= "審核日期："+@audit.real_audit_date.strftime("%Y年%m月%d日星期%w")+" "+@audit.real_audit_time.to_s

		pdf.bounding_box([2.7.cm ,24.cm  ], :width => 17.cm ) do
			pdf.font_size (14){pdf.text "時間過得真快，又該安排稽核了!!\n根據雙方的協定時間，本公司將對貴公司進行 #{servicetext} 年度審核\n#{text3}", :leading => 8,:align => :left,:overflow => :shrink_to_fit
			}
		end

		pdf.bounding_box([10.cm ,pdf.cursor+0.8.cm  ], :width => 5.cm ) do
			pdf.font_size (12){pdf.text "證書到期:", :leading => 0,:align => :right,:overflow => :shrink_to_fit
			}
		end



		pdf.bounding_box([15.cm ,pdf.cursor+0.5.cm  ], :width => 5.cm ) do
			pdf.font_size (12){pdf.text "#{expirationtext}", :leading => 0,:align => :left,:overflow => :shrink_to_fit
			}
		end





		

		pdf.bounding_box([2.cm ,20.8.cm  ], :width => 16.cm ,:height => 1.cm,:style=>:bold) do
			pdf.font_size (20){pdf.text "基本資料",:align => :left,:bold => :true, :backcolor=>:yellow
			}
		end

		pdf.bounding_box([2.cm ,20.cm  ], :width => 16.cm ,:height => 1.cm,:style=>:bold) do
			pdf.font_size (14){pdf.text "Ref No. (文件編號)：<u>#{@customer.customer_num}</u>",:align => :left,:bold => :true,:inline_format => true
			}
		end	

		pdf.bounding_box([2.cm ,19.3.cm  ], :width => 18.cm ,:height => 1.cm,:style=>:bold) do
			pdf.font_size (14){pdf.text "Company Name (公司名稱)：<u>#{@customer.customer_chi}</u>",:overflow => :shrink_to_fit,:align => :left,:bold => :true,:inline_format => true
			}
		end


		pdf.bounding_box([2.cm ,18.6.cm  ], :width => 18.cm ,:height => 0.8.cm,:style=>:bold) do
			pdf.font_size (14){pdf.text "Address (地址)：<u>#{@customer.contact_addr}</u>",:align => :left,:bold => :true,:inline_format => true,:overflow => :shrink_to_fit
			}
		end


		pdf.bounding_box([2.cm ,17.9.cm  ], :width => 16.cm ,:height => 1.cm,:style=>:bold) do
			pdf.font_size (14){pdf.text "Contact Name (聯繫人)：<u>#{@customer.contact_ppl}           </u>",:align => :left,:bold => :true,:inline_format => true
			}
		end

		pdf.bounding_box([2.cm ,17.2.cm  ], :width => 16.cm ,:height => 1.cm,:style=>:bold) do
			pdf.font_size (13){pdf.text "TEL(電話)：<u>#{@customer.contact_tel}</u> FAX(傳真)：<u>#{@customer.fax_num}</u> Staff(員工人數)：<u>#{@customer.staff_num}</u>",:align => :left,:bold => :true,:inline_format => true,:overflow => :shrink_to_fit
			}
		end

		pdf.bounding_box([2.cm ,16.5.cm  ], :width => 16.cm ,:height => 1.cm,:style=>:bold) do
			pdf.font_size (13){pdf.text "Audit site(認證地點)：<u>#{@audit.address1_chi}</u>",:align => :left,:inline_format => true,:bold => :true
			}
		end

		pdf.bounding_box([2.cm ,15.8.cm  ], :width => 16.cm ,:style=>:bold) do
			pdf.font_size (14){pdf.text "Scope (認證範圍)：",:align => :left,:bold => :true,:inline_format => true
			}
		end
		pdf.bounding_box([6.7.cm ,15.8.cm  ], :width => 13.cm ,:style=>:bold) do
			pdf.font_size (14){pdf.text "<u>#{@audit.scope_eng}</u>",:align => :left,:bold => :true,:inline_format => true
			}
		end



		pdf.bounding_box([2.cm ,pdf.cursor ], :width => 18.cm ,:style=>:bold) do
			pdf.font_size (14){pdf.text "Standard Applied(認證標準)： <u>#{servicetext}</u>",:align => :left,:bold => :true,:inline_format => true
			}
		end

		pdf.line_width=2	
		pdf.stroke_horizontal_line 2.cm,18.4.cm

		pdf.line_width=1	

		temp =pdf.cursor

		if @project.total_amount

			pdf.bounding_box([2.7.cm ,temp-10  ], :width => 16.cm ,:style=>:bold) do
				pdf.font_size (13){pdf.text "Application Fee           申請費               新台幣",:align => :left,:bold => :true
				}
			end
			pdf.stroke_horizontal_line 13.3.cm,18.3.cm, :at => temp-0.8.cm


			temp =pdf.cursor
			pdf.bounding_box([2.7.cm ,temp-5], :width => 16.cm,:style=>:bold) do
				pdf.font_size (13){pdf.text "Audit Fee                 驗證費用             新台幣",:align => :left,:bold => :true,:inline_format => true
				}
			end
			
			pdf.bounding_box([12.7.cm ,temp-5], :width => 5.cm,:style=>:bold) do
				pdf.font_size (13){pdf.text "#{number_to_currency(@project.total_amount, :precision => 0)}",:align => :right,:bold => :true,:inline_format => true
				}
			end
			pdf.stroke_horizontal_line 13.3.cm,18.3.cm, :at => temp-0.65.cm

			temp =pdf.cursor
			pdf.bounding_box([2.7.cm ,pdf.cursor-5 ], :width => 16.cm,:style=>:bold) do
				pdf.font_size (13){pdf.text "Tax                       稅金(5%)             新台幣",:align => :left,:bold => :true,:inline_format => true
				}
			end
			pdf.bounding_box([12.7.cm ,temp-5], :width => 5.cm,:style=>:bold) do
				pdf.font_size (13){pdf.text "#{number_to_currency(@project.total_amount*0.05, :precision => 0)}",:align => :right,:bold => :true,:inline_format => true
				}
			end

			pdf.stroke_horizontal_line 13.3.cm,18.3.cm, :at => temp-0.65.cm

			temp =pdf.cursor
			pdf.bounding_box([2.7.cm ,pdf.cursor-5 ], :width => 16.cm ,:style=>:bold) do
				pdf.font_size (13){pdf.text "Total                     總計                 新台幣",:align => :left,:bold => :true,:inline_format => true
				}
			end



			pdf.bounding_box([12.7.cm ,temp-5], :width => 5.cm,:style=>:bold) do
				pdf.font_size (13){pdf.text "#{number_to_currency(@project.total_amount*1.05, :precision => 0)}",:align => :right,:bold => :true,:inline_format => true
				}
			end

		end
		pdf.stroke_horizontal_line 13.3.cm,18.3.cm, :at => temp-0.65.cm
		
		pdf.move_down 10
		
		pdf.line_width=2	
		
		pdf.stroke_horizontal_line 2.cm,18.4.cm 

		pdf.fill_ellipse [2.7.cm, pdf.cursor-1.cm], 5
		pdf.bounding_box([3.3.cm ,pdf.cursor-0.7.cm ], :width => 16.cm ,:style=>:bold) do
			pdf.font_size (14){pdf.text "收到「驗證通知單」後，請於二日內來電回應或回傳確認。",:align => :left,:bold => :true,:inline_format => true
			}
		end
		pdf.fill_ellipse [2.7.cm, pdf.cursor-1.cm], 5
		pdf.bounding_box([3.3.cm ,pdf.cursor-0.7.cm ], :width => 16.cm ,:style=>:bold) do
			pdf.font_size (14){pdf.text "請確認貴公司之基本資料。",:align => :left,:bold => :true,:inline_format => true
			}
		end

		pdf.bounding_box([3.3.cm ,6.7.cm ], :width => 10.cm ,:style=>:bold) do
			pdf.image "app/assets/images/喬治亞發票章.jpeg", :width => 4.3.cm
			
		end

		bg = "app/assets/images/formbg/#{@type}.jpeg" 


		pdf.line_width=1	
		pdf.stroke_horizontal_line 2.cm,9.5.cm, :at => 3.cm

		pdf.stroke_horizontal_line 10.5.cm,17.5.cm, :at => 3.cm
		pdf.bounding_box([3.3.cm ,2.7.cm ], :width => 7.cm ,:style=>:bold) do
			pdf.font_size (12){pdf.text "喬治亞國際開發股份有限公司\n日期:#{@date.strftime("%Y/%m/%d")}",:align => :left,:bold => :true,:inline_format => true
			}
		end

		pdf.bounding_box([11.8.cm ,2.7.cm ], :width => 7.cm ,:style=>:bold) do
			pdf.font_size (12){pdf.text "經理/管理代表 簽章並回傳\n職務/日期",:align => :left,:bold => :true,:inline_format => true
			}
		end
	else
		pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"
		pdf.bounding_box([5.8.cm ,23.cm ], :width => 7.cm ,:style=>:bold) do
			pdf.font_size (12){pdf.text "請輸入稽核日期",:align => :left,:bold => :true,:inline_format => true
			}
		end
	end
end
if @type == "續評通過函(友意)"
		if @audit.certificate_get_date
			pdf.font "#{Prawn::BASEDIR}/data/fonts/ARIALUNI.ttf"
			bg = "app/assets/images/formbg/#{@type}.jpeg" 
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm

			pdf.bounding_box([1.9.cm ,24.2.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "#{@audit.certificate_get_date.strftime("%d %b, %Y")}",:align => :left,:bold => :true,:inline_format => true
				}
			end

			pdf.bounding_box([1.9.cm ,23.1.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (13){pdf.text "#{@customer.customer_chi}",:align => :left,:bold => :true,:inline_format => true
				}
			end
			pdf.bounding_box([1.9.cm ,22.5.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (13){pdf.text "#{@customer.customer_eng}",:align => :left,:bold => :true,:inline_format => true
				}
			end

			pdf.bounding_box([1.9.cm ,21.5.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (13){pdf.text "#{@audit.address1_chi}",:align => :left,:bold => :true,:inline_format => true
				}
			end
			pdf.bounding_box([1.9.cm ,20.5.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (13){pdf.text "#{@audit.address1_eng}",:align => :left,:bold => :true,:inline_format => true
				}
			end

			pdf.bounding_box([1.9.cm ,18.2.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "#{@audit.CB_number}-SURVEILLANCE AUDIT REPORT",:align => :left,:bold => :true,:inline_format => true
				}
			end

			pdf.bounding_box([1.9.cm ,18.2.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "#{@audit.CB_number}-SURVEILLANCE AUDIT REPORT",:align => :left,:bold => :true,:inline_format => true
				}
			end

			pdf.bounding_box([1.9.cm ,16.2.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "The surveillance audit of #{@audit.service.name} for #{@customer.customer_eng} had been finished.",:align => :left,:bold => :true,:inline_format => true
				}
			end

			pdf.bounding_box([1.9.cm ,14.0.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "Client,#{@customer.customer_eng},has been recommanded for certification registration against #{@audit.service.name}	",:align => :left,:bold => :true,:inline_format => true
				}
			end

			pdf.bounding_box([1.9.cm ,12.8.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "#{@audit.CB_number} was valid in the TQCSI website(<u>http://www.tqcsi.com/v2.0/tqcsi_track.asp</u>)",:align => :left,:bold => :true,:inline_format => true
				}
			end


			pdf.bounding_box([1.9.cm ,11.0.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "#{@customer.customer_chi}已完成#{@audit.service.name}之續評稽核。稽核的結果良好，且有符合ISO 19011 之相關規定。 \n",:align => :left,:bold => :true,:inline_format => true,:leading =>14
				}
			end

			pdf.bounding_box([1.9.cm ,9.2.cm ], :width => 18.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "貴公司之 #{@audit.service.name} 證書到期日： #{@audit.certificate.expiration_date.strftime("%Y年%m月%d日")}， 證書已經被確認持續有效， 並且被登錄在TQCSI網站上。",:align => :left,:bold => :true,:inline_format => true,:leading =>2
				}
			end
			pdf.bounding_box([1.9.cm ,7.8.cm ], :width => 19.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "而客戶編號#{@audit.CB_number}在TQCSI 網站上 (<u>http://www.tqcsi.com/v2.0/tqcsi_track.asp</u>) 是有效， 且可以查詢的",:align => :left,:bold => :true,:inline_format => true,:leading =>2
				}
			end
	else
			pdf.font "#{Prawn::BASEDIR}/data/fonts/ARIALUNI.ttf"

			pdf.bounding_box([1.9.cm ,17.8.cm ], :width => 19.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "無證書寄送日期",:align => :left,:bold => :true,:inline_format => true,:leading =>2
				}
			end
	end			
end
if @type == "續評通過函(喬治亞)"
		if @audit.certificate_get_date
				pdf.font "#{Prawn::BASEDIR}/data/fonts/ARIALUNI.ttf"
				bg = "app/assets/images/formbg/#{@type}.jpeg" 
				pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm



				pdf.bounding_box([1.9.cm ,23.5.cm ], :width => 18.cm ,:style=>:bold) do
					pdf.font_size (13){pdf.text "致    #{@customer.customer_chi}",:align => :left,:bold => :true,:inline_format => true
					}
				end
				pdf.bounding_box([1.9.cm ,22.9.cm ], :width => 18.cm ,:style=>:bold) do
					pdf.font_size (13){pdf.text "to   #{@customer.customer_eng}",:align => :left,:bold => :true,:inline_format => true
					}
				end

				pdf.bounding_box([1.9.cm ,21.2.cm ], :width => 18.cm ,:style=>:bold) do
					pdf.font_size (12){pdf.text "#{@audit.certificate_get_date.strftime("%d %b, %Y")}",:align => :left,:bold => :true,:inline_format => true
					}
				end

				pdf.bounding_box([1.9.cm ,20.0.cm ], :width => 18.cm ,:style=>:bold) do
					pdf.font_size (13){pdf.text "#{@audit.address1_chi}",:align => :left,:bold => :true,:inline_format => true
					}
				end
				pdf.bounding_box([1.9.cm ,19.5.cm ], :width => 18.cm ,:style=>:bold) do
					pdf.font_size (13){pdf.text "#{@audit.address1_eng}",:align => :left,:bold => :true,:inline_format => true
					}
				end

				pdf.bounding_box([1.9.cm ,18.2.cm ], :width => 18.cm ,:style=>:bold) do
					pdf.font_size (12){pdf.text "Dear Sir,\n#{@audit.CB_number}-SURVEILLANCE AUDIT REPORT\nThis is to certify:\nThe surveillance audit of #{@audit.service.name} for #{@customer.customer_eng} had been finished.\nThis audit was conducted well, and it was accord with the ISO 19011 requirement.\nClient,#{@customer.customer_eng},has been recommanded for certification registration against #{@audit.service.name}\n#{@audit.CB_number} was valid in the TQCSI website(<u>http://www.tqcsi.com/v2.0/tqcsi_track.asp</u>)	",:align => :left,:bold => :true,:inline_format => true, :leading=>8
					}
				end

				

				pdf.bounding_box([1.9.cm ,11.0.cm ], :width => 18.cm ,:style=>:bold) do
					pdf.font_size (12){pdf.text "#{@customer.customer_chi}已完成#{@audit.service.name}之續評稽核。稽核的結果良好，且有符合ISO 19011 之相關規定。 \n",:align => :left,:bold => :true,:inline_format => true,:leading =>14
					}
				end

				pdf.bounding_box([1.9.cm ,9.2.cm ], :width => 18.cm ,:style=>:bold) do
					pdf.font_size (12){pdf.text "貴公司之 #{@audit.service.name} 證書到期日： #{@audit.certificate.expiration_date.strftime("%Y年%m月%d日")}， 證書已經被確認持續有效， 並且被登錄在TQCSI網站上。",:align => :left,:bold => :true,:inline_format => true,:leading =>2
					}
				end
				pdf.bounding_box([1.9.cm ,7.8.cm ], :width => 19.cm ,:style=>:bold) do
					pdf.font_size (12){pdf.text "而客戶編號#{@audit.CB_number}在TQCSI 網站上 (<u>http://www.tqcsi.com/v2.0/tqcsi_track.asp</u>) 是有效， 且可以查詢的",:align => :left,:bold => :true,:inline_format => true,:leading =>2
					}
				end
		else
			pdf.font "#{Prawn::BASEDIR}/data/fonts/ARIALUNI.ttf"

			pdf.bounding_box([1.9.cm ,17.8.cm ], :width => 19.cm ,:style=>:bold) do
				pdf.font_size (12){pdf.text "無證書寄送日期",:align => :left,:bold => :true,:inline_format => true,:leading =>2
				}
			end
		end
end
if @type == "證書"
	if @audit.certificate
		if (@preview=='1')

			bg = "app/assets/images/bg.jpg" 
			pdf.image bg, :at => [0.cm,29.7.cm],:width =>21.cm
		end


		if (@audit.certificate.certificate_type == '認證')
			
				manager = "app/assets/images/manager.jpg" 
			    pdf.image manager, :at => [2.5.cm,5.cm], :width => 4.7.cm 


				iaf = "app/assets/images/iaf.jpg" 
			    pdf.image iaf, :at => [7.8.cm,5.cm], :width => 2.8.cm

				dakks = "app/assets/images/dakks2.jpg" 
			    pdf.image dakks, :at => [10.7.cm,5.2.cm], :width => 5.5.cm 
		 
		else
			
				manager = "app/assets/images/manager.jpg" 
			    pdf.image manager, :at => [2.5.cm,5.cm], :width => 4.7.cm  

			    royalcert = "app/assets/images/royalcert.jpg" 
			    pdf.image royalcert, :at => [8.3.cm,5.5.cm], :width => 4.cm 

		end


		pdf.font "#{Prawn::BASEDIR}/data/fonts/Candara.ttf"
		pdf.bounding_box([2.9.cm ,21.65.cm  ], :width => 16.cm ,:height => 1.cm) do
			pdf.font_size (10){pdf.text 'Royalcert, certifies that the management system of the organization has been assessed and found to be in accordance with the requirements of the related standard',:align => :center
			}
		end

		pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
		pdf.bounding_box([2.9.cm ,20.cm  ], :width => 16.cm ,:height => 1.cm,:style =>[:italic]) do
			pdf.font_size (20){
			pdf.formatted_text [{:text=> @audit.service.name,:align =>:center}],:align =>:center
			}
		end

		pdf.bounding_box([2.9.cm ,17.3.cm  ], :width => 16.cm ,:height => 1.cm,:style => :normal) do

			if @ver=="chi"
				pdf.font ("#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"), :style => :bold
				pdf.font_size (22){
				pdf.text @customer.customer_chi,:align =>:center,:bold=>:true
				}
			else
				pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf", :style => :bold
				pdf.font_size (22){
				pdf.text_box @customer.customer_eng,:align =>:center
				}
			end	

		end

		pdf.bounding_box([2.9.cm ,15.6.cm  ], :width => 16.cm ,:height => 1.8.cm) do
			
			if @ver=="chi"
				pdf.font_size (14){
				pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf", :style => :normal
				pdf.text @audit.address1_chi.to_s+"\n"+@audit.address2_chi.to_s+"\n"+@audit.address3_chi.to_s+"\n"+@audit.address4_chi.to_s,:align =>:center,:overflow => :shrink_to_fit,:bold=>:false
				}
			else
				pdf.font_size (14){
				pdf.font "#{Prawn::BASEDIR}/data/fonts/Candara.ttf"
				pdf.text @audit.address1_eng.to_s+"\n"+@audit.address2_eng.to_s+"\n"+@audit.address3_eng.to_s+"\n"+@audit.address4_eng.to_s,:align =>:center,:overflow => :shrink_to_fit
				}

			end


		end

		pdf.bounding_box([2.9.cm ,12.5.cm  ], :width => 16.cm ,:height => 1.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (14){
			pdf.text "Scope",:align =>:center
			}
		end


		pdf.bounding_box([2.9.cm ,11.6.cm  ], :width => 15.5.cm, :height=>2.5.cm ) do
			if @ver=="chi"
				pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf", :style => :normal
				pdf.font_size (14){
				pdf.text @audit.scope_chi,:align =>:center,:overflow => :shrink_to_fit
				}
			else
				pdf.font "#{Prawn::BASEDIR}/data/fonts/Candara.ttf", :style => :normal
				pdf.font_size (14){
				pdf.text @audit.scope_eng,:align =>:center,:overflow => :shrink_to_fit
				}
			end
		end

		pdf.bounding_box([3.cm ,8.7.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			pdf.text "Certification No",:bold=>:true

			}
		end
		pdf.bounding_box([7.5.cm ,8.7.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			pdf.text ": "+@audit.certificate.certificate_num.to_s,:bold=>:true

			}
		end



		pdf.bounding_box([3.cm ,8.1.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			pdf.text "Initial Certification Date",:bold=>:true

			}
		end
		pdf.bounding_box([7.5.cm ,8.1.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			if @certificate.initial_date
				pdf.text ": "+@audit.certificate.initial_date.strftime("%d.%m.%Y").to_s,:bold=>:true
			end
			}
		end


		pdf.bounding_box([3.cm ,7.5.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			pdf.text "Issue Date",:bold=>:true

			}
		end
		pdf.bounding_box([7.5.cm ,7.5.cm ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			if @certificate.issue_date
				pdf.text ": "+@audit.certificate.issue_date.strftime("%d.%m.%Y").to_s,:bold=>:true
			end
			}
		end


		pdf.bounding_box([3.cm ,6.8.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			pdf.text "Expiration Date",:bold=>:true

			}
		end
		pdf.bounding_box([7.5.cm ,6.8.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			if (@certificate.expiration_date)
				pdf.text ": "+@audit.certificate.expiration_date.strftime("%d.%m.%Y").to_s,:bold=>:true
			end
			}
		end


		pdf.bounding_box([2.3.cm ,5.9.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
			pdf.font_size (10){
			pdf.text "Certification Manager",:bold=>:true
			}
		end
	else

		pdf.bounding_box([2.3.cm ,15.9.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
			pdf.font ("#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"), :style => :bold
			pdf.font_size (13){pdf.text "請先核發證書",:bold=>:true
			}
		end

	end
end 