require 'test_helper'

class ArticlesCrudTest < ActionDispatch::IntegrationTest


  def setup
    @user = users(:michael)
  end


  test "successfully show unexpired news articles" do
    get news_path
    assert_template 'articles/news'
    assert_response :success
    assert assigns(:articles)
  end


  test "successfully list index of articles" do
    log_in_as(@user)
    get articles_path
    assert_template 'articles/index'
    assert_response :success
    assert assigns(:articles)
  end


  test "successfully add a new article" do
    log_in_as(@user)
    get new_article_path
    assert_template 'articles/new'

    assert_difference 'Article.count', 1 do
      post articles_path, article: { title: 'something new', body: 'something new', owner_id:@user.id }
    end

    assert_not flash.empty?
    assert_redirected_to articles_path
  end


  test "successfully update an article" do
    log_in_as(@user)
    a = Article.last
    old_name = a.title

    get edit_article_path(a.id)
    assert_template 'articles/edit'

    patch article_path(a.id), article: { title: old_name + "-e" }
    assert_not flash.empty?
    assert_redirected_to articles_path
    a2 = Article.last
    assert_equal old_name + "-e",  a2.title
  end


  test "successfully delete an article" do
    log_in_as(@user)
    a = Article.last

    assert_difference 'Article.count', -1 do
      delete_via_redirect article_path(a.id)
    end

    assert_not flash.empty?
    assert_equal path, articles_path

  end

end
