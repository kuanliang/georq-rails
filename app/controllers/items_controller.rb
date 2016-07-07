class ItemsController < ApplicationController
	 before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy] 

	def index
# @date = params[:month] ? Date.parse(params[:month]) : Date.today
		 @items = Item.all
		 #@customer = Customer.all
    	 #@project = Project.find(params[:project_id])
		 @items_projects=ItemsProject.all
	end
	
	
	def new
		 @item = Item.new
	end

	def edit
  	  @item = Item.find(params[:id])
  	  @company = Company.all
  	end

	 def create
	    @item = Item.create(item_params)
	    #@customer = current_user.groups.new(group_params)
	  
	    if @item.save
	      redirect_to root_url, notice: "新增品項"
	      #redirect_to :back, notice: "新增客戶成功"
	    #  current_user.join!(@group)
	    else
	      render :new
	    end
	  end
	 def update
	     @item = Item.find(params[:id])
	    # @group = current_user.groups.find(params[:id])

	     if @item.update(item_params)
	       redirect_to items_path, notice: "修改品項成功"

	       #redirect_to :back, notice: "修改客戶資料成功"
	     else
	       render :edit
	     end
	  end
    def destroy
    	@item = Item.find(params[:id])
        #@customer = current_user.customer.find(params[:id])
        @item.destroy
        redirect_to items_path, alert: "品項已經刪除"
    end
private
  
  def item_params 
    params.require(:item).permit(:contract_name, :invoice_name, :company_id)
  end
end
 
