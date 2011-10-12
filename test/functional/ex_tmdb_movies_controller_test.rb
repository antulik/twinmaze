require 'test_helper'

class ExTmdbMoviesControllerTest < ActionController::TestCase
  setup do
    @ex_tmdb_movie = ex_tmdb_movies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ex_tmdb_movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ex_tmdb_movie" do
    assert_difference('ExTmdbMovie.count') do
      post :create, :ex_tmdb_movie => @ex_tmdb_movie.attributes
    end

    assert_redirected_to ex_tmdb_movie_path(assigns(:ex_tmdb_movie))
  end

  test "should show ex_tmdb_movie" do
    get :show, :id => @ex_tmdb_movie.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ex_tmdb_movie.to_param
    assert_response :success
  end

  test "should update ex_tmdb_movie" do
    put :update, :id => @ex_tmdb_movie.to_param, :ex_tmdb_movie => @ex_tmdb_movie.attributes
    assert_redirected_to ex_tmdb_movie_path(assigns(:ex_tmdb_movie))
  end

  test "should destroy ex_tmdb_movie" do
    assert_difference('ExTmdbMovie.count', -1) do
      delete :destroy, :id => @ex_tmdb_movie.to_param
    end

    assert_redirected_to ex_tmdb_movies_path
  end
end
