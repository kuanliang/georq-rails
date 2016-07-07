class AuditMonthsController < ApplicationController

 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 

	def index
# @date = params[:month] ? Date.parse(params[:month]) : Date.today
		 @audit_months = AuditMonth.all
		 #@customer = Customer.all
    	 #@project = Project.find(params[:project_id])
		 #@items_projects=ItemsProject.all
	end
	
	
	def new
		 @audit_month = AuditMonth.new
	end

	def edit
  	  @audit_month = AuditMonth.find(params[:id])
  	  #@company = Company.all
  	end

	 def create
	    @audit_month = AuditMonth.create(audit_month_params)
	    #@customer = current_user.groups.new(group_params)
	  
	    if @audit_month.save
	      redirect_to root_url, notice: "新增月份"
	      #redirect_to :back, notice: "新增客戶成功"
	    #  current_user.join!(@group)
	    else
	      render :new
	    end
	  end
	 def update
	     @audit_month = AuditMonth.find(params[:id])
	    # @group = current_user.groups.find(params[:id])

	     if @audit_month.update(audit_month_params)
	       redirect_to items_path, notice: "修改月份成功"

	       #redirect_to :back, notice: "修改客戶資料成功"
	     else
	       render :edit
	     end
	  end
    def destroy
    	@audit_month = AuditMonth.find(params[:id])
        #@customer = current_user.customer.find(params[:id])
        @audit_month.destroy
        redirect_to items_path, alert: "月份已經刪除"
    end
private
  
  def audit_month_params 
    params.require(:audit_month).permit(:name, :customer_id)
  end



end
