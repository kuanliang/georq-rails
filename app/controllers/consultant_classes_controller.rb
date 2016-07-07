class ConsultantClassesController < ApplicationController
 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy]  
 def new

 	@customer = Customer.find(params[:customer_id])
    @project = Project.find(params[:project_id])
    @consultant = Consultant.find(params[:consultant_id])
    @consultant_class = @consultant.consultant_classes.new
    
 end
 
 def edit

    @services = Service.all
    @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @consultant = Consultant.find(params[:consultant_id])
    @consultant_class = @consultant.consultant_classes.find(params[:id])
 end
 
 def create
 	@customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @consultant = Consultant.find(params[:consultant_id])
    @consultant_class = @consultant.consultant_classes.build(consultant_class_params)
 
    if @consultant_class.save
      #redirect_to customer_project_consultant_path(@customer,@project,@consultant), notice: "新增成功！"
      redirect_to customer_project_path(@customer,@project), notice: "新增上課日期成功！"
      #redirect_to account_consultants_path, notice: "新增專案成功！"
    else
      render :new
    end
 end
 
 def update
 	 @customer = Customer.find(params[:customer_id])	
 	@project = Project.find(params[:project_id])
    @consultant = Consultant.find(params[:consultant_id])
    @consultant_class = @consultant.consultant_classes.find(params[:id])
 
    if @consultant_class.update(consultant_class_params)
      redirect_to customer_project_path(@customer,@project), notice: "修改成功！"

    else
      render :edit
    end
 end
 
 def destroy
 	
 	 @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @consultant = Consultant.find(params[:consultant_id])
    @consultant_class = @consultant.consultant_classes.find(params[:id])
 
    @consultant_class.destroy
    redirect_to customer_project_path(@customer,@project), alert: "課程已刪除"
 end
    private
   
    def consultant_class_params
      params.require(:consultant_class).permit(:class_content, :class_date )
    end
end
 