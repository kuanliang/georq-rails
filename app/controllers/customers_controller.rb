class CustomersController < ApplicationController
require 'csv'
#id,customer_num,identification_num,customer_chi,customer_eng,owner,staff_num,site_num,mr_chi,mr_eng,mr_pos,fax_num,contact_tel,contact_email,contact_ppl,contact_addr,office_addr_chi,office_addr_eng,factory_addr_cht,factory_addr_eng,level,comment,created_at,updated_at
	

   before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy,:history] 
  def import
          
                if params[:file].blank?
                  
                    redirect_to root_url ,notice: '請選擇檔案'
                else
                    #Customer.from_csv!(csv_file)
             	 	Customer.import(params[:file])
             		redirect_to root_url, notice: "Customers imported."
                end
	end

  

	def index


# @date = params[:month] ? Date.parse(params[:month]) : Date.today
		  #@date = params[:month] ? Date.parse(params[:month]) : Date.today
		
		 #@customers = Customer.all.selected_tag(@tag)
		 #@customers = Customer.all
		 @tags = Tag.all
         #@ta=Tag.all.selected_tag(@tag)
         #@customers=@tags2.customers

         stopcontrol = 0

        if params[:search]
           # @customers = Customer.where('customer_chi LIKE ? OR customer_eng LIKE ? OR customer_num LIKE ? OR identification_num LIKE ? OR owner LIKE ? OR mr_chi LIKE ? OR contact_tel LIKE ? OR comment LIKE ? OR level LIKE ?', "%#{params[:search]}%" , "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
            #@customers = Customer.where('customer_chi LIKE ? OR customer_eng LIKE ? ', "%#{params[:search]}%", "%#{params[:search]}%")
        #elsif params[:tag] 
        #	if params[:tag] == "all"
        #		@customers = Customer.joins(:customers_tags,:tags).all.distinct	
        #	elsif params[:tag] == "stop"
         #   @customers = Customer.where(:stop=> true)
          #  @stopcontrol = 1
          #else
        	#@tag = params[:tag]
        	#@tag = Customer.where('customer_chi LIKE ? OR customer_eng LIKE ? OR customer_num LIKE ? OR identification_num LIKE ? OR owner LIKE ? OR mr_chi LIKE ? OR contact_tel LIKE ? OR comment LIKE ? OR level LIKE ?', "%#{params[:search]}%" , "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
        	#@tag = Tag.where('tag_name LIKE ?', "%#{params[:tag]}%") 
        	#@customers = @tag.customers_tags.customer
        	#@tps=@tag.customers_tag
        	#@customers = @tag.customers
        	#@customers = Customer.joins(:customers_tags,:tags).where('tag_name LIKE ?', "#{params[:tag]}").distinct
        	#end
        else

            @customers = Customer.all
        end

        respond_to do |format|
        if params[:search]

            @q= Customer.where('customer_chi LIKE ? OR customer_eng LIKE ? OR customer_num LIKE ? OR identification_num LIKE ? OR owner LIKE ? OR mr_chi LIKE ? OR contact_tel LIKE ? OR comment LIKE ? OR level LIKE ?', "%#{params[:search]}%" , "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").ransack(params[:q])   
            @customers = @q.result.distinct.order(:customer_num).paginate(:page => params[:page])
            #@customers = Customer.where('customer_chi LIKE ? OR customer_eng LIKE ? ', "%#{params[:search]}%", "%#{params[:search]}%")
        
        else
            @q = Customer.ransack(params[:q])
            #@search.build_grouping unless @search.groupings.any?
           # if params[:stop].to_i==1
            #  @customers = @q.result.where(:stop => :true).distinct.order(:customer_num).paginate(:page => params[:page])#.page(params[:page])
           # elsif params[:stop].to_i==0
             # @customers = @q.result.where(:stop => :false).distinct.order(:customer_num).paginate(:page => params[:page])#.page(params[:page])
           # else
               @customers = @q.result.distinct.order(:customer_num).paginate(:page => params[:page])#.page(params[:page])
            #@customers = Customer.order(:customer_num).page params[:page]
            #@customers = Customer.all
            #end
        end

        	format.html
        	format.csv {

        		filename = "Customers-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"
                #@customers.to_csv
        		send_data(@customers.to_csv, :type => "text/xls; charset=utf-8; header=present",:filename => filename)
        	}
        	format.xls {send_data @customers.to_csv(col_sep: "\t")}
        end
	end
	
	def show
    if params[:customer]
      @customer = Customer.find(params[:customer])
    else
	   @customer = Customer.find(params[:id])
    end
	  #@customer = Customer.find(params[:id])
	  @projects = @customer.projects

    @audits=@customer.audits
    @forms = Form.all
    
    #@audit= Audit.find.find(params[:id])
 	 #@posts = @group.posts
    #@post= Post.all
 	end
	def new
		 @customer = Customer.new
     @project=@customer.projects.build

     @audit=@project.audits.build
     #@certificate=@audit.certificate.build
     @certificate=@audit.build_certificate
		 @tags = Tag.all
	end

	def edit
  	  @customer = Customer.find(params[:id])
  	  @tags = Tag.all
  	end
  	def edit2
  	  @customer = Customer.find(params[:id])
  	end

	 def create
	    @customer = Customer.create(customer_params)
	    #@customer = current_user.groups.new(group_params)
	  
	    if @customer.save
	      redirect_to root_url, notice: "新增客戶成功"
	      #redirect_to :back, notice: "新增客戶成功"
	    #  current_user.join!(@group)
	    else
	      render :new
	    end
	  end
	 def update
	     @customer = Customer.find(params[:id])
	    # @group = current_user.groups.find(params[:id])
         # if @customer.assign_attributes(customer_params)
	     if @customer.update(customer_params)
	      # redirect_to customers_path, notice: "修改客戶資料成功"
            redirect_to :back, notice: "修改客戶資料成功"
	       #redirect_to :back, notice: "修改客戶資料成功"
	     else
	       render :edit
	     end
	  end
    def destroy
    	@customer = Customer.find(params[:id])
        #@customer = current_user.customer.find(params[:id])
        @customer.destroy
        redirect_to customers_path, alert: "客戶已經刪除"
    end
def updateall

     #@customers = Customer.all
     Customer.updateall()
     #updateall()
     redirect_to customers_path()
end
def history
     
            @customers = Customer.all
end
def continue
    @customer = Customer.find(params[:id])

      @customer.continueproject()
      flash[:notice] = "續約成功"
    #id=params[:format]
    #@customer = Customer.find(params[:id])

    redirect_to customer_path(@customer)
  end

private
  
  def customer_params 
    params.require(:customer).permit({:audit_month_ids => []},:stop, :stop_date,:stop_reason,:CB_number,:certification_body,:audit_standard,:scope_chi,:scope_eng,:orginal_audit_date,:contact_addr, :office_addr_chi, :office_addr_eng, :factory_addr_cht, :factory_addr_eng, :comment,:fax_num,:contact_ppl,:level,:customer_num,:site_num,:staff_num,:mr_chi,:mr_eng,:mr_pos, :customer_chi,:customer_eng,:owner,:contact_tel,:contact_email,:identification_num,  {tag_ids: []},projects_attributes:[:id,:customer_id,:real_audit_date,:total_amount,:_destroy,audits_attributes:[:id,:service_id,:certification_body,:audit_standard,:scope_chi,:scope_eng,:_destroy,certificate_attributes:[:certificate_num,:certificate_type,:initial_date,:issue_date,:expiration_date,:status,:comment]]]  )
  end
end
#,certificates_attributes:[:certificate_num,:certificate_type,:initial_date,:issue_date,:expiration_date]
 #,audits_attributes:[:id,:audit_standard,:scope_chi,:_destroy]
 #projects_attributes:[:customer_id,:real_audit_date,:total_amount,:_destroy],
