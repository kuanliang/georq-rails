class CustomersTagsController < ApplicationController
	 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 

  def new

 	@customer = Customer.find(params[:customer_id])
    @customers_tag = @customer.customers_tags.new

    #@items_project = @project.items_projects.new
 end
 
 def edit

    @tags = Tag.all
    @customer = Customer.find(params[:customer_id])
    @customers_tag = @customer.customers_tags.find(params[:id])
 end
 
 def create
 	@customer = Customer.find(params[:customer_id])
    @customers_tag = @customer.customers_tags.build(customers_tag_params)
 
    if @customers_tag.save
      #redirect_to customer_project_consultant_path(@customer,@project,@consultant), notice: "新增成功！"
      redirect_to customers_path(), notice: "新增標籤成功！"
      #redirect_to account_consultants_path, notice: "新增專案成功！"
    else
      render :new
    end
 end
 
 def update
 	 @customer = Customer.find(params[:customer_id])	
    @customers_tag = @customer.customers_tags.find(params[:id])
 
    if @customers_tag.update(customers_tag_params)
      redirect_to customer_path(@customer), notice: "修改成功！"

    else
      render :edit
    end
 end
 
 def destroy
 	
 	 @customer = Customer.find(params[:customer_id])
    @customers_tag = ItItemsProject.find(params[:id])
 
    @customers_tag.destroy
    redirect_to customer_path(@customer), alert: "已刪除"
 end
    private
   
    def customers_tag_params
      params.require(:customers_tag).permit(:tag_id)
    end
end
