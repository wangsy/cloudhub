class CloudStoragesController < ApplicationController
  before_action :set_cloud_storage, only: [:show, :edit, :update, :destroy]

  # GET /cloud_storages
  # GET /cloud_storages.json
  def index
    @cloud_storages = CloudStorage.all
  end

  # GET /cloud_storages/1
  # GET /cloud_storages/1.json
  def show
  end

  # GET /cloud_storages/new
  def new
    @cloud_storage = CloudStorage.new
  end

  # GET /cloud_storages/1/edit
  def edit
  end

  # POST /cloud_storages
  # POST /cloud_storages.json
  def create
    @cloud_storage = CloudStorage.new(cloud_storage_params)

    respond_to do |format|
      if @cloud_storage.save
        format.html { redirect_to @cloud_storage, notice: 'Cloud storage was successfully created.' }
        format.json { render :show, status: :created, location: @cloud_storage }
      else
        format.html { render :new }
        format.json { render json: @cloud_storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cloud_storages/1
  # PATCH/PUT /cloud_storages/1.json
  def update
    respond_to do |format|
      if @cloud_storage.update(cloud_storage_params)
        format.html { redirect_to @cloud_storage, notice: 'Cloud storage was successfully updated.' }
        format.json { render :show, status: :ok, location: @cloud_storage }
      else
        format.html { render :edit }
        format.json { render json: @cloud_storage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cloud_storages/1
  # DELETE /cloud_storages/1.json
  def destroy
    @cloud_storage.destroy
    respond_to do |format|
      format.html { redirect_to cloud_storages_url, notice: 'Cloud storage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cloud_storage
      @cloud_storage = CloudStorage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cloud_storage_params
      params.require(:cloud_storage).permit(:name, :access_token)
    end
end
