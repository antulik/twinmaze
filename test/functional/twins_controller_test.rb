require 'test_helper'

class TwinsControllerTest < ActionController::TestCase
  setup do
    @twin = twins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twin" do
    assert_difference('Twin.count') do
      post :create, :twin => @twin.attributes
    end

    assert_redirected_to twin_path(assigns(:twin))
  end

  test "should show twin" do
    get :show, :id => @twin.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @twin.to_param
    assert_response :success
  end

  test "should update twin" do
    put :update, :id => @twin.to_param, :twin => @twin.attributes
    assert_redirected_to twin_path(assigns(:twin))
  end

  test "should destroy twin" do
    assert_difference('Twin.count', -1) do
      delete :destroy, :id => @twin.to_param
    end

    assert_redirected_to twins_path
  end
end
