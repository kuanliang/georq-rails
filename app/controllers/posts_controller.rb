class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_group
  before_action :member_required, only: [:new, :create ]
  def new
  	#@group = Group.find(params[:group_id])
    @post = @group.posts.new
  end
  
  def edit
  	#@group = Group.find(params[:group_id])
    #@post = @group.posts.find(params[:id])

    @post = current_user.posts.find(params[:id])
  end
  
  def create
    #@group = Group.find(params[:group_id])
    @post = @group.posts.build(post_params)
    @post.author = current_user
 
    if @post.save
      redirect_to group_path(@group), notice: "新增文章成功！"
    else
      render :new
    end
  end
  
  def update
  	#@group = Group.find(params[:group_id])
    #@post = @group.posts.find(params[:id])
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to group_path(@group), notice: "文章修改成功！"
    else
      render :edit
    end
  end
  
  def destroy
  	#@group = Group.find(params[:group_id])
    @post = @group.posts.find(params[:id])
    @post = current_user.posts.find(params[:id])
 
    @post.destroy
    redirect_to group_path(@group), alert: "文章已刪除"
  end
  private
   def post_params
     params.require(:post).permit(:content,:name,:date,:company,:classname,:teacher,:content2,:content3)
   end
   def find_group
      @group = Group.find(params[:group_id])
   end  
   def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "你不是這個討論版的成員，不能發文喔！"
      redirect_to group_path(@group)
    end
  end
end
