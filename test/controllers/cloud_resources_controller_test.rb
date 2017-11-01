require 'test_helper'

class CloudResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cloud_resource = cloud_resources(:one)
  end

  test "should get index" do
    get cloud_resources_url
    assert_response :success
  end

  test "should get new" do
    get new_cloud_resource_url
    assert_response :success
  end

  test "should create cloud_resource" do
    assert_difference('CloudResource.count') do
      post cloud_resources_url, params: { cloud_resource: { client_modified: @cloud_resource.client_modified, content_hash: @cloud_resource.content_hash, name: @cloud_resource.name, parent_id: @cloud_resource.parent_id, path_display: @cloud_resource.path_display, path_lower: @cloud_resource.path_lower, resource_id: @cloud_resource.resource_id, resource_type: @cloud_resource.resource_type, rev: @cloud_resource.rev, server_modified: @cloud_resource.server_modified, size: @cloud_resource.size } }
    end

    assert_redirected_to cloud_resource_url(CloudResource.last)
  end

  test "should show cloud_resource" do
    get cloud_resource_url(@cloud_resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_cloud_resource_url(@cloud_resource)
    assert_response :success
  end

  test "should update cloud_resource" do
    patch cloud_resource_url(@cloud_resource), params: { cloud_resource: { client_modified: @cloud_resource.client_modified, content_hash: @cloud_resource.content_hash, name: @cloud_resource.name, parent_id: @cloud_resource.parent_id, path_display: @cloud_resource.path_display, path_lower: @cloud_resource.path_lower, resource_id: @cloud_resource.resource_id, resource_type: @cloud_resource.resource_type, rev: @cloud_resource.rev, server_modified: @cloud_resource.server_modified, size: @cloud_resource.size } }
    assert_redirected_to cloud_resource_url(@cloud_resource)
  end

  test "should destroy cloud_resource" do
    assert_difference('CloudResource.count', -1) do
      delete cloud_resource_url(@cloud_resource)
    end

    assert_redirected_to cloud_resources_url
  end
end
