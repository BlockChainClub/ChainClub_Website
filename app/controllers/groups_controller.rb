class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  before_action :validate_search_key, only: [:search]

  def index
    @groups = Group.published.recent.paginate(:page => params[:page], :per_page => 12)

    @posts = case params[:order]
             when 'by_hot'
               #按评论数量排序,后期改为只比较最近一周的
               Post.all.paginate(:page => params[:page], :per_page => 10).sort_by{|post| -post.post_comments.count}
             else
               Post.all.recent.paginate(:page => params[:page], :per_page => 10)
             end
  end

  def show
    @group = Group.find(params[:id])
    set_page_title @group.title
    set_page_description "#{@group.description}"
    # 随机推荐5个相同类型的话题（去除当前话题），后期修改为真正的相关话题
    @commends = Group.published.where.not(:id => @group.id ).random5
    @posts = case params[:order]
             when 'by_hot'
               #按评论数量排序
               @group.posts.paginate(:page => params[:page], :per_page => 10).sort_by{|post| -post.post_comments.count}

             else
               @group.posts.recent.paginate(:page => params[:page], :per_page => 10)
             end
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice:"更新成功！"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: "删除成功！"
  end

  def join
   @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "成功加入该小组！"
    else
      flash[:warning] = "你已经是本讨论版成员了！"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本讨论版！"
    else
      flash[:warning] = "你不是本讨论版成员，怎么退出 XD"
    end

    redirect_to group_path(@group)
  end

  def search
    if @query_string.present?
      search_result = Group.ransack(@search_criteria).result(:distinct => true)
      @groups = search_result.paginate(:page => params[:page], :per_page => 20 )
    end
  end


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end

  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "抱歉，您没有相应的权限！"
    end
  end

  def group_params
    params.require(:group).permit(:title, :logo, :remove_logo, :description, :status)
  end

end
