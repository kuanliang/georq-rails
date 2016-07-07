class ItemsProjectsController < ApplicationController
	 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 

  def new

 	@customer = Customer.find(params[:customer_id])
    @project = Project.find(params[:project_id])
    @items_project = @project.items_projects.new
 end
 
 def edit

    @services = Service.all
    @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @items_project = @project.items_projects.find(params[:id])
 end
 
 def create
 	@customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @items_project = @project.items_projects.build(items_project_params)
 
    if @items_project.save
      #redirect_to customer_project_consultant_path(@customer,@project,@consultant), notice: "新增成功！"
      redirect_to customer_path(@customer), notice: "新增服務款項！"
      #redirect_to account_consultants_path, notice: "新增專案成功！"
    else
      render :new
    end
 end
 
 def update
 	 @customer = Customer.find(params[:customer_id])	
 	@project = Project.find(params[:project_id])
    @items_project = @project.items_projects.find(params[:id])
 
    if @items_project.update(items_project_params)
      redirect_to customer_path(@customer), notice: "修改成功！"

    else
      render :edit
    end
 end
 
 def destroy
 	
 	 @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @items_project = ItemsProject.find(params[:id])
 
    @items_project.destroy
    redirect_to customer_path(@customer), alert: "已刪除"
 end
    private
   
    def items_project_params
      params.require(:items_project).permit(:item_id,:pay_status,:ratio,:get_money_people,:get_money_date)
    end
end
