require 'test_helper'

class MovieListItemsControllerTest < ActionController::TestCase
  setup do
    @movie_list_item = movie_list_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_list_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_list_item" do
    assert_difference('MovieListItem.count') do
      post :create, :movie_list_item => @movie_list_item.attributes
    end

    assert_redirected_to movie_list_item_path(assigns(:movie_list_item))
  end

  test "should show movie_list_item" do
    get :show, :id => @movie_list_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @movie_list_item.to_param
    assert_response :success
  end

  test "should update movie_list_item" do
    put :update, :id => @movie_list_item.to_param, :movie_list_item => @movie_list_item.attributes
    assert_redirected_to movie_list_item_path(assigns(:movie_list_item))
  end

  test "should destroy movie_list_item" do
    assert_difference('MovieListItem.count', -1) do
      delete :destroy, :id => @movie_list_item.to_param
    end

    assert_redirected_to movie_list_items_path
  end
end
