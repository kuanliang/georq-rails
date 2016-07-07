class CompaniesController < ApplicationController
	 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy]  
	def index



       
            @companies = Company.all

	end
	
	def show
	  @company = Company.find(params[:id])
	  #@customer = Customer.find(params[:id])
	 
 	 #@posts = @group.post
    #@post= Post.all
 	end
	def new
		 @company = Company.new
		 @tags = Tag.all
	end

	def edit
  	  @company = Company.find(params[:id])
  	  @tags = Tag.all
  	end
  	def edit2
  	  @company = Company.find(params[:id])
  	end

	 def create
	    @company = Company.create(company_params)
	    #@customer = current_user.groups.new(group_params)
	  
	    if @company.save
	      redirect_to root_url, notice: "新增客戶成功"
	      #redirect_to :back, notice: "新增客戶成功"
	    #  current_user.join!(@group)
	    else
	      render :new
	    end
	  end
	 def update
	     @company = Company.find(params[:id])
	    # @group = current_user.groups.find(params[:id])

	     if @company.update(company_params)
	       redirect_to companies_path, notice: "修改客戶資料成功"

	       #redirect_to :back, notice: "修改客戶資料成功"
	     else
	       render :edit
	     end
	  end
    def destroy
    	@company = Company.find(params[:id])
        #@customer = current_user.customer.find(params[:id])
        @company.destroy
        redirect_to companies_path, alert: "客戶已經刪除"
    end
private
  
  def company_params 
    params.require(:company).permit(:company_name, :company_address,:company_tel,:company_fax)
  end
end
