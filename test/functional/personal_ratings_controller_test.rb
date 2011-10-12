require 'test_helper'

class PersonalRatingsControllerTest < ActionController::TestCase
  setup do
    @personal_rating = personal_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personal_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personal_rating" do
    assert_difference('PersonalRating.count') do
      post :create, :personal_rating => @personal_rating.attributes
    end

    assert_redirected_to personal_rating_path(assigns(:personal_rating))
  end

  test "should show personal_rating" do
    get :show, :id => @personal_rating.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @personal_rating.to_param
    assert_response :success
  end

  test "should update personal_rating" do
    put :update, :id => @personal_rating.to_param, :personal_rating => @personal_rating.attributes
    assert_redirected_to personal_rating_path(assigns(:personal_rating))
  end

  test "should destroy personal_rating" do
    assert_difference('PersonalRating.count', -1) do
      delete :destroy, :id => @personal_rating.to_param
    end

    assert_redirected_to personal_ratings_path
  end
end
