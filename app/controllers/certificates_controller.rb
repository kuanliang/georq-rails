class CertificatesController < ApplicationController
 require 'pdf/writer'
 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy,:senddate,:asr]  

 #respond_to :html 
 #<%=Audit.oins(:project,:service).where("audit_type LIKE ?","正評").where("contract_start_date LIKE ? ","%#{2011+n}%").accreditation("Royalcert").count*a*g+Audit.joins(:project,:service).where("audit_type LIKE ?","%SV%").where("contract_start_date LIKE ? ","%#{2011+n}%").accreditation("Royalcert").count*b*g+Audit.joins(:project,:service).where("audit_type LIKE ?","%RA%").where("contract_start_date LIKE ? ","%#{2011+n}%").accreditation("Royalcert").count*c*g+Audit.joins(:project,:service).where("audit_type LIKE ?","正評").where("contract_start_date LIKE ? ","%#{2011+n}%").where("contract_start_date LIKE ? ","%#{2011+n}%").nonaccreditation("Royalcert").count*d*g+Audit.joins(:project,:service).where("audit_type LIKE ?","%SV%").where("contract_start_date LIKE ? ","%#{2011+n}%").nonaccreditation("Royalcert").count*e*g+Audit.joins(:project,:service).where("audit_type LIKE ?","%RA%").where("contract_start_date LIKE ? ","%#{2011+n}%").nonaccreditation("Royalcert").count*f*g%>
def senddate
   respond_to do |format|
      @q = Certificate.ransack(params[:q])
        @date = params[:month] ? Date.parse(params[:month]) : Date.today
        
        @certificates=@q.result.joins(:audit).where(audits:{:certificate_send_date => @date.beginning_of_month..@date.end_of_month}).distinct
        format.html
        format.csv {
        filename = "certificates-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"
                  
              send_data(@certificates.to_csv, :type => "text/xls; charset=utf-8; header=present",:filename => filename)
            }
          
          #format.xls {send_data @customers.to_csv(col_sep: "\t")}  
    end
end
def asr
    #respond_to do |format|
        @q = Certificate.ransack(params[:q])
        @date = params[:month] ? Date.parse(params[:month]) : Date.today
        #@certificates= Certificate.all
        @certificates=@q.result.joins(:audit).where(audits:{:certificate_send_date => @date.beginning_of_month..@date.end_of_month}).distinct
        @num= @certificates.count
        #  if params[:format]=="":proje

            #format.html
        #    format.csv {

         #     filename = "certificates-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"
                  #@customers.to_csv
          #    send_data(@certificates.to_csv, :type => "text/xls; charset=utf-8; header=present",:filename => filename)
           # }
          #end
          #format.xls {send_data @customers.to_csv(col_sep: "\t")}  
    #end

end

 def index
    #@certificates = Certificate.all
  @q = Certificate.ransack(params[:q])
  #@givemoney = params[:givemoney]
    #@search.build_grouping unless @search.groupings.any?
    @certificates = @q.result.distinct.order(issue_date: :desc).paginate(:page => params[:page])#.page(params[:page])
    # @num= @certificates.count.where()
    #@customer= Customer.where(:certificate )
#respond_with @audits
   # respond_to @certificates

  #  @certificates = Certificate.order(issue_date: :desc).page params[:page]
   # @tags = Tag.all
  end
   
  def new

 	@customer = Customer.find(params[:customer_id])

    @project = Project.find(params[:project_id])


    @audit = Audit.find(params[:audit_id])
    2.times do
      @certificate = @audit.build_certificate
    end


     #5.times do
      #consultant_class = @consultant.consultant_classes.build
    #end
 end
 
def show
  
    @customer = Customer.find(params[:customer_id])
    #@customer = Customer.find(params[:id])
    

    @project = Project.find(params[:project_id])


    @audit = Audit.find(params[:audit_id])
    @certificate = @audit.certificate
    @ver = params[:ver]
    @preview = params[:preview]

     @addr_h = params[:addr_h]
     @addr_w = params[:addr_w]
     @scope_h = params[:scope_h]
     @scope_w = params[:scope_w]
     @name_h= params[:name_h]
     @name_w = params[:name_w]
     


     @iaf =params[:iaf]
      # respond_to do |format|
         
        #  format.html
       #   format.pdf {

        #    filename = "Certificate-#{Time.now.strftime("%Y%m%d%H%M%S")}.pdf"
       #     render pdf: generate_pdf(@certificate), :type => "application/pdf", :disposition => 'inline',:filename => filename
            #send_data(@customers.to_csv, :type => "text/xls; charset=utf-8; he#{}ader=present",:filename => filename)
        
      #    }
          
    #    end
   
   #@posts = @group.posts
    #@post= Post.all
  end


 def edit

    @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])

    @audit = Audit.find(params[:audit_id])

    @certificate = @audit.certificate
 end
 
 def create
 	@customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])

    @audit = Audit.find(params[:audit_id])

    @certificate = @audit.build_certificate(certificate_params)
      
    if @certificate.save
      redirect_to customer_project_path(@customer,@project), notice: "新增成功！"
      #redirect_to account_consultants_path, notice: "新增專案成功！"
      #redirect_to :back, notice: "修改證書資料成功"
    else
      render :new
    end
 end
 
 def update
 	 @customer = Customer.find(params[:customer_id])	
 	@project = Project.find(params[:project_id])
    @audit = Audit.find(params[:audit_id])
    @certificate = @audit.certificate
 
    if @certificate.update(certificate_params)
      #redirect_to customer_project_audit_path(@customer,@project,@audit), notice: "修改成功！"
      redirect_to customer_project_path(@customer,@project), notice: "修改證書資料成功"
    else
      render :edit
    end
 end
 
 def destroy
 	
 	 @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @audit = Audit.find(params[:audit_id])

    @certificate = @audit.certificate
 
    @certificate.destroy
    redirect_to  customer_project_path(@customer,@project), alert: "證書已刪除"
 end

def sendcertificate

    @certificate = Certificate.find(params[:id])
    @audit=@certificate.audit
    @audit.sendcertificate()
      flash[:notice] = "標記成功"
    #id=params[:format]
    #@customer = Customer.find(params[:id])
    #redirect_to certificates_path()
    redirect_to certificates_path()
   # redirect_to customers_path()

end

def getcertificate

    @certificate = Certificate.find(params[:id])
    @audit=@certificate.audit
    @audit.getcertificate()
      flash[:notice] = "標記成功"
    #id=params[:format]
    #@customer = Customer.find(params[:id])
    #redirect_to certificates_path()
    redirect_to certificates_path()
   # redirect_to customers_path()

end
#def continue
 #   @customer = Customer.find(params[:id])

     # @customer.continueproject()
    #  flash[:notice] = "續約成功"
   
   # redirect_to customer_path(@customer)
  #end


    private
   
    def certificate_params
      params.require(:certificate).permit(:certificate_num,:certificate_type,:initial_date,:issue_date,:expiration_date,:status,:comment)
    end


    def generate_pdf(certificate)
      

    if (@certificate.certificate_type == "認證")
      pdf = Prawn::Document.new(:page_size => "A4",:margin => [0, 0, 0, 0]) do


        filename = "tmp/Sreport_#{Time.now.to_s}.pdf"


         bg = "app/assets/images/bg.jpg" 
          image bg, :at => [0.cm,29.7.cm],:width =>21.cm

        manager = "app/assets/images/manager.jpg" 
          image manager, :at => [2.5.cm,5.cm], :width => 4.7.cm 


        iaf = "app/assets/images/iaf.jpg" 
          image iaf, :at => [7.8.cm,5.cm], :width => 2.8.cm

        dakks = "app/assets/images/dakks2.jpg" 
          image dakks, :at => [10.7.cm,5.2.cm], :width => 5.5.cm 

         text "Email: #{certificate.certificate_num}"
     
      end.render
    else
      pdf = Prawn::Document.new(:page_size => "A4",:margin => [0, 0, 0, 0]) do
        filename = "tmp/Sreport_#{Time.now.to_s}.pdf"

         bg = "app/assets/images/bg.jpg" 
          image bg, :at => [0.cm,29.7.cm],:width =>21.cm

        manager = "app/assets/images/manager.jpg" 
          image manager, :at => [2.5.cm,5.cm], :width => 4.7.cm  

          royalcert = "app/assets/images/royalcert.jpg" 
          image royalcert, :at => [8.3.cm,5.5.cm], :width => 4.cm 

         
      end.render
    end

    #pdf.stroke_axis
    if false
    pdf.font "#{Prawn::BASEDIR}/data/fonts/kaiu.ttf"




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
        pdf.text @audit.address1_chi+"\n"+@audit.address2_chi+"\n"+@audit.address3_chi+"\n"+@audit.address4_chi,:align =>:center,:overflow => :shrink_to_fit,:bold=>:false
        }
      else
        pdf.font_size (14){
        pdf.font "#{Prawn::BASEDIR}/data/fonts/Candara.ttf"
        pdf.text @audit.address1_eng+"\n"+@audit.address2_eng+"\n"+@audit.address3_eng+"\n"+@audit.address4_eng,:align =>:center,:overflow => :shrink_to_fit
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
      pdf.text ": "+@certificate.certificate_num.to_s,:bold=>:true

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
        pdf.text ": "+@certificate.initial_date.strftime("%d.%m.%Y").to_s,:bold=>:true
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
        pdf.text ": "+@certificate.issue_date.strftime("%d.%m.%Y").to_s,:bold=>:true
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
        pdf.text ": "+@certificate.expiration_date.strftime("%d.%m.%Y").to_s,:bold=>:true
      end
      }
    end


    pdf.bounding_box([2.3.cm ,5.9.cm  ], :width => 4.6.cm ,:height => 0.5.cm) do
      pdf.font "#{Prawn::BASEDIR}/data/fonts/GOTHICB.ttf"
      pdf.font_size (10){
      pdf.text "Certification Manager",:bold=>:true
      }
    end

    end

    end


end
