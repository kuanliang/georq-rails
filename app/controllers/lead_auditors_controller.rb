class LeadAuditorsController < ApplicationController



	 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 

	def index
# @date = params[:month] ? Date.parse(params[:month]) : Date.today
		 @lead_auditors = LeadAuditor.all
		 #@customer = Customer.all
    	 #@project = Project.find(params[:project_id])
		 #@items_projects=ItemsProject.all
	end
	
	
	def new
		 @lead_auditor = LeadAuditor.new
	end

	def edit
  	  @lead_auditor = LeadAuditor.find(params[:id])
  	  #@company = Company.all
  	end

	 def create
	    @lead_auditor = LeadAuditor.create(lead_auditor_params)
	    #@customer = current_user.groups.new(group_params)
	  
	    if @lead_auditor.save
	      redirect_to lead_auditors_path, notice: "新增主任稽核員"
	      #redirect_to :back, notice: "新增客戶成功"
	    #  current_user.join!(@group)
	    else
	      render :new
	    end
	  end
	 def update
	     @lead_auditor = LeadAuditor.find(params[:id])
	    # @group = current_user.groups.find(params[:id])

	     if @lead_auditor.update(lead_auditor_params)
	       redirect_to lead_auditors_path, notice: "修改主任稽核員成功"

	       #redirect_to :back, notice: "修改客戶資料成功"
	     else
	       render :edit
	     end
	  end
    def destroy
    	@lead_auditor = LeadAuditor.find(params[:id])
        #@customer = current_user.customer.find(params[:id])
        @lead_auditor.destroy
        redirect_to lead_auditors_path, alert: "主任稽核員已經刪除"
    end
private
  
  def lead_auditor_params 
    params.require(:lead_auditor).permit(:name_en, :name_chi,)
  end


end
