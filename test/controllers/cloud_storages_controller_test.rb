require 'test_helper'

class CloudStoragesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cloud_storage = cloud_storages(:one)
  end

  test "should get index" do
    get cloud_storages_url
    assert_response :success
  end

  test "should get new" do
    get new_cloud_storage_url
    assert_response :success
  end

  test "should create cloud_storage" do
    assert_difference('CloudStorage.count') do
      post cloud_storages_url, params: { cloud_storage: { access_token: @cloud_storage.access_token, name: @cloud_storage.name } }
    end

    assert_redirected_to cloud_storage_url(CloudStorage.last)
  end

  test "should show cloud_storage" do
    get cloud_storage_url(@cloud_storage)
    assert_response :success
  end

  test "should get edit" do
    get edit_cloud_storage_url(@cloud_storage)
    assert_response :success
  end

  test "should update cloud_storage" do
    patch cloud_storage_url(@cloud_storage), params: { cloud_storage: { access_token: @cloud_storage.access_token, name: @cloud_storage.name } }
    assert_redirected_to cloud_storage_url(@cloud_storage)
  end

  test "should destroy cloud_storage" do
    assert_difference('CloudStorage.count', -1) do
      delete cloud_storage_url(@cloud_storage)
    end

    assert_redirected_to cloud_storages_url
  end
end
