class ServicesController < ApplicationController
		

  before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 

  def index
   @services = Service.all
  end
  def show
  @service = Service.find(params[:id])
 # @posts = @group.posts
    #@post= Post.all
  end
 
  def new
    @service = Service.new
  end
   
  def edit
    @service = Service.find(params[:id])
  end
 
  def create
    @service = Service.create(service_params)
    #@group = current_user.groups.new(group_params)
  
    if @service.save
      redirect_to services_path, notice: "新增服務項目成功"
    else
      render :new
    end
  end
 
  def update
     @service = Service.find(params[:id])
     #@group = current_user.groups.find(params[:id])

     if @service.update(service_params)
       redirect_to services_path, notice: "修改討論版成功"
     else
       render :edit
     end
  end
 
  def destroy
        @service = Service.find(params[:id])
        #@group = current_user.groups.find(params[:id])
        @service.destroy
        redirect_to services_path, alert: "服務項目已刪除"
  end

  
 
 private
  
  def service_params 
    params.require(:service).permit(:kind, :name, :alias, :description)
  end
end

