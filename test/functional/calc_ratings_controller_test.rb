require 'test_helper'

class CalcRatingsControllerTest < ActionController::TestCase
  setup do
    @calc_rating = calc_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calc_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calc_rating" do
    assert_difference('CalcRating.count') do
      post :create, :calc_rating => @calc_rating.attributes
    end

    assert_redirected_to calc_rating_path(assigns(:calc_rating))
  end

  test "should show calc_rating" do
    get :show, :id => @calc_rating.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @calc_rating.to_param
    assert_response :success
  end

  test "should update calc_rating" do
    put :update, :id => @calc_rating.to_param, :calc_rating => @calc_rating.attributes
    assert_redirected_to calc_rating_path(assigns(:calc_rating))
  end

  test "should destroy calc_rating" do
    assert_difference('CalcRating.count', -1) do
      delete :destroy, :id => @calc_rating.to_param
    end

    assert_redirected_to calc_ratings_path
  end
end
