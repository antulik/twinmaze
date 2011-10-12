require 'test_helper'

class MovieListsControllerTest < ActionController::TestCase
  setup do
    @movie_list = movie_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_list" do
    assert_difference('MovieList.count') do
      post :create, :movie_list => @movie_list.attributes
    end

    assert_redirected_to movie_list_path(assigns(:movie_list))
  end

  test "should show movie_list" do
    get :show, :id => @movie_list.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @movie_list.to_param
    assert_response :success
  end

  test "should update movie_list" do
    put :update, :id => @movie_list.to_param, :movie_list => @movie_list.attributes
    assert_redirected_to movie_list_path(assigns(:movie_list))
  end

  test "should destroy movie_list" do
    assert_difference('MovieList.count', -1) do
      delete :destroy, :id => @movie_list.to_param
    end

    assert_redirected_to movie_lists_path
  end
end
