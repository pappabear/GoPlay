class ArticlesController < ApplicationController


  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, except: :news


  def news
    @articles = Article.where("((published_at < ?) or (published_at is null))", Date.today)
                       .where("((expired_at > ?) or (expired_at is null))", Date.today)
  end


  def index
    @articles = Article.all
  end


  def show
  end


  def new
    @article = Article.new
  end


  def edit
    @article.expired_at = @article.expired_at.strftime("%m/%d/%Y") unless @article.expired_at.nil?
    @article.published_at = @article.published_at.strftime("%m/%d/%Y") unless @article.published_at.nil?
  end


  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html {
          flash[:success] = "News story was successfully created."
          redirect_to articles_path
        }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html {
          flash[:success] = "News story was successfully updated."
          redirect_to articles_path
        }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @article.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "News story was successfully deleted."
        redirect_to articles_path
      }
      format.json { head :no_content }
    end
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :body, :published_at, :expired_at, :owner_id)
  end


  # Confirms an admin user.
  def admin_user
    if !is_admin?
      flash[:danger] = 'You must be an admin to perform that function.'
      redirect_to(login_path)
    end
  end


end
