class FormsController < ApplicationController
 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 
  def index
   @forms = Form.all
  end
  def show
  @form = Form.find(params[:id])
 # @posts = @group.posts
    #@post= Post.all
  end
 
  def new
    @form = Form.new
  end
   
  def edit
    @form = Form.find(params[:id])
  end
 
  def create
    @form = Form.create(form_params)
    #@group = current_user.groups.new(group_params)
  
    if @form.save
      redirect_to forms_path, notice: "新增服務項目成功"
    else
      render :new
    end
  end
 
  def update
     @form = Form.find(params[:id])
     #@group = current_user.groups.find(params[:id])

     if @form.update(form_params)
       redirect_to forms_path, notice: "修改討論版成功"
     else
       render :edit
     end
  end
 
  def destroy
        @form = Form.find(params[:id])
        #@group = current_user.groups.find(params[:id])
        @form.destroy
        redirect_to forms_path, alert: "服務項目已刪除"
  end

  
 
 private
  
  def form_params 
    params.require(:form).permit(:name,:describe,:version,:follow,:company,:file,:background1,:background2,:background3)
  end
end
