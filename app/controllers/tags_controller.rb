class TagsController < ApplicationController
	 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 
# @date = params[:month] ? Date.parse(params[:month]) : Date.today
		 @tags = Tag.all
	end
	
	
	def new
		 @tag = Tag.new
	end

	def edit
  	  @tag = Tag.find(params[:id])
  	end

	 def create
	    @tag = Tag.create(tag_params)
	    #@customer = current_user.groups.new(group_params)
	  
	    if @tag.save
	      redirect_to root_url, notice: "新增標籤"
	      #redirect_to :back, notice: "新增客戶成功"
	    #  current_user.join!(@group)
	    else
	      render :new
	    end
	  end
	 def update
	     @tag = Tag.find(params[:id])
	    # @group = current_user.groups.find(params[:id])

	     if @tag.update(tag_params)
	       redirect_to tags_path, notice: "修改標籤成功"

	       #redirect_to :back, notice: "修改客戶資料成功"
	     else
	       render :edit
	     end
	  end
    def destroy
    	@tag = Tag.find(params[:id])
        #@customer = current_user.customer.find(params[:id])
        @tag.destroy
        redirect_to tags_path, alert: "標籤已經刪除"
    end
private
  
  def tag_params 
    params.require(:tag).permit(:tag_name,:follow)
  end
end
