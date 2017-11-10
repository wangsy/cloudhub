class CloudResourcesController < ApplicationController
  before_action :set_cloud_resource, only: [:show, :edit, :update, :destroy]

  # GET /cloud_resources
  # GET /cloud_resources.json
  def index
    # @cloud_resources = CloudResource.all
    root = CloudResource.find_root
    root = params[:id] || root.id
    @cloud_resource = CloudResource.find root.to_i
    @cloud_resources = @cloud_resource.children(params[:page] || 1)
  end

  # GET /cloud_resources/1
  # GET /cloud_resources/1.json
  def show
  end

  # GET /cloud_resources/new
  def new
    @cloud_resource = CloudResource.new
  end

  # GET /cloud_resources/1/edit
  def edit
  end

  # POST /cloud_resources
  # POST /cloud_resources.json
  def create
    @cloud_resource = CloudResource.new(cloud_resource_params)

    respond_to do |format|
      if @cloud_resource.save
        format.html { redirect_to @cloud_resource, notice: 'Cloud resource was successfully created.' }
        format.json { render :show, status: :created, location: @cloud_resource }
      else
        format.html { render :new }
        format.json { render json: @cloud_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cloud_resources/1
  # PATCH/PUT /cloud_resources/1.json
  def update
    respond_to do |format|
      if @cloud_resource.update(cloud_resource_params)
        format.html { redirect_to @cloud_resource, notice: 'Cloud resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @cloud_resource }
      else
        format.html { render :edit }
        format.json { render json: @cloud_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cloud_resources/1
  # DELETE /cloud_resources/1.json
  def destroy
    @cloud_resource.destroy
    respond_to do |format|
      format.html { redirect_to cloud_resources_url, notice: 'Cloud resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cloud_resource
      @cloud_resource = CloudResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cloud_resource_params
      params.require(:cloud_resource).permit(:name, :path_lower, :path_display, :resource_id, :client_modified, :server_modified, :rev, :size, :content_hash, :parent_id, :resource_type)
    end
end
