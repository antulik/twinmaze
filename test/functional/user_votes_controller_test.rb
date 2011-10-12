require 'test_helper'

class UserVotesControllerTest < ActionController::TestCase
  setup do
    @movie_rating = movie_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_rating" do
    assert_difference('UserVote.count') do
      post :create, :movie_rating => @movie_rating.attributes
    end

    assert_redirected_to movie_rating_path(assigns(:movie_rating))
  end

  test "should show movie_rating" do
    get :show, :id => @movie_rating.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @movie_rating.to_param
    assert_response :success
  end

  test "should update movie_rating" do
    put :update, :id => @movie_rating.to_param, :movie_rating => @movie_rating.attributes
    assert_redirected_to movie_rating_path(assigns(:movie_rating))
  end

  test "should destroy movie_rating" do
    assert_difference('UserVote.count', -1) do
      delete :destroy, :id => @movie_rating.to_param
    end

    assert_redirected_to movie_ratings_path
  end
end
