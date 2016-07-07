  class ProjectsController < ApplicationController

   before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 

   def import
          
                if params[:file].blank?
                  
                    redirect_to projects_path() ,notice: '請選擇檔案'
                else
                    #Customer.from_csv!(csv_file)
                Project.import(params[:file])
                   redirect_to projects_path(), notice: "Projects imported."
                end
  end 
  def index

   @projects = Project.all.order(contract_start_date: :desc)
    respond_to do |format|
      format.html
      format.csv {

            filename = "Projects-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"
                #@customers.to_csv
            send_data(@projects.to_csv, :type => "text/xls; charset=utf-8; header=present",:filename => filename)
          }
          format.xls {send_data @projects.to_csv(col_sep: "\t")}
    end

  end
  
  def show
  @customer = Customer.find(params[:customer_id])
  @project = Project.find(params[:id])
  @consultants = @project.consultants
  @audits = @project.audits
    #@post= Post.all
  end
def new
   
      @services = Service.all
      @customer = Customer.find(params[:customer_id])
        @project = @customer.projects.new
        
        @items=Item.all
        @companies=Company.all



 end
 
 def edit

  @services = Service.all
 	@customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:id])
    @items=Item.all
    @companies=Company.all
 end
 def edit2

  @services = Service.all
  @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:id])
 end
 
 def create
 	@customer = Customer.find(params[:customer_id])
    @project = @customer.projects.build(project_params)
 
    if @project.save
      #redirect_to customer_path(@customer), notice: "新增專案成功！"
      #redirect_to account_projects_path, notice: "新增專案成功！"
      redirect_to :back, notice: "新增專案成功！"
    else
      render :new
    end
 end
 
 def update
 	@customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:id])
 
    if @project.update(project_params)
      #redirect_to customer_path(@customer), notice: "專案修改成功！"
      #redirect_to account_projects_path, notice: "專案修改成功！"
      redirect_to :back, notice: "專案修改成功！"
    else
      render :edit
    end
 end
 
 def destroy
 	  @customer = Customer.find(params[:customer_id])
    @project = @customer.projects.find(params[:id])
 
    @project.destroy
    redirect_to customer_path(@customer), alert: "專案已刪除"
 end
    private
   
    def project_params
      params.require(:project).permit(:customer_id,:project_type,:total_amount,:currency,:audit_date,:kind,:project_id, :all_audit_standard,:contract,:contract_start_date,:partyb,:real_audit_time, :project_manager,:report_get_date,:report_send_date,:certificate_get_date,:certificate_send_date,:pay_status,:status,:comment, {:item_ids => []}, {:service_ids => []})
    end
end
