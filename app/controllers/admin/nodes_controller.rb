class Admin::NodesController < Admin::BaseController
  before_action :find_node, only: [:show, :edit, :update, :destroy]

  def index
    @nodes = Node.sorted.includes(:section)
  end

  def show
  end

  def new
    @node = Node.new
  end

  def edit
  end

  def create
    @node = Node.new(params[:node].permit!)

    if @node.save
      redirect_to(admin_nodes_path, notice: "Node was successfully created.")
    else
      render action: "new"
    end
  end

  def update
    if @node.update(params[:node].permit!)
      redirect_to(admin_nodes_path, notice: "Node was successfully updated.")
    else
      render action: "edit"
    end
  end

  def destroy
    @node.destroy
    redirect_to(admin_nodes_url)
  end

  private

  def find_node
    @node = Node.find(params[:id])
  end

end
