require 'test_helper'

class UserTwinsControllerTest < ActionController::TestCase
  setup do
    @user_twin = user_twins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_twins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_twin" do
    assert_difference('UserTwin.count') do
      post :create, :user_twin => @user_twin.attributes
    end

    assert_redirected_to user_twin_path(assigns(:user_twin))
  end

  test "should show user_twin" do
    get :show, :id => @user_twin.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user_twin.to_param
    assert_response :success
  end

  test "should update user_twin" do
    put :update, :id => @user_twin.to_param, :user_twin => @user_twin.attributes
    assert_redirected_to user_twin_path(assigns(:user_twin))
  end

  test "should destroy user_twin" do
    assert_difference('UserTwin.count', -1) do
      delete :destroy, :id => @user_twin.to_param
    end

    assert_redirected_to user_twins_path
  end
end
