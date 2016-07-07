class ConsultantsController < ApplicationController
 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 

 def new

 	@customer = Customer.find(params[:customer_id])

    @project = Project.find(params[:project_id])

    @services = Service.all
    @consultant = @project.consultants.new

    5.times do
      consultant_class = @consultant.consultant_classes.build
    end
 end
 
 def edit

    @services = Service.all
    @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @consultant = @project.consultants.find(params[:id])
 end
 
 def create
 	@customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @consultant = @project.consultants.build(consultant_params)
 
    if @consultant.save
      redirect_to customer_project_path(@customer,@project), notice: "新增成功！"
      #redirect_to account_consultants_path, notice: "新增專案成功！"
    else
      render :new
    end
 end
 
 def update
 	 @customer = Customer.find(params[:customer_id])	
 	@project = Project.find(params[:project_id])
    @consultant = @project.consultants.find(params[:id])
 
    if @consultant.update(consultant_params)
      redirect_to customer_project_path(@customer,@project), notice: "修改成功！"

    else
      render :edit
    end
 end
 
 def destroy
 	
 	 @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @consultant = @project.consultants.find(params[:id])
 
    @consultant.destroy
    redirect_to customer_project_path(@customer,@project), alert: "專案已刪除"
 end
    private
   
    def consultant_params
      params.require(:consultant).permit(:service_id,:contract_date, :consultant_standard, :consultor, :comment,consultant_classes_attributes:[:id,:class_content, :class_date])
    end
end

