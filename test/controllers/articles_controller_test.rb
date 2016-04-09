require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  setup do
    @article = articles(:one)
    @user = users(:michael)
  end


  test "news should work" do
    get :news
    assert_response :success
    assert_not_nil assigns(:articles)
  end


  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end


  test "should redirect edit when not logged in" do
    get :edit, id: @article
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @article, article: { title: @article.title + '-e', body: @article.body + '-e' }
    assert_redirected_to login_url
  end


  test "should get index" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end


  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end


  test "should create article" do
    log_in_as(@user)
    assert_difference('Article.count') do
      post :create, article: { title: @article.title + '-new', body: @article.body + '-new', owner_id:@user.id }
    end

    assert_redirected_to articles_path
  end


  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @article
    assert_response :success
  end


  test "should update article" do
    log_in_as(@user)
    patch :update, id: @article, article: { title: @article.title + '-e', body: @article.body + '-e' }
    assert_redirected_to articles_path
  end


  test "should destroy article" do
    log_in_as(@user)
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
  end


end
