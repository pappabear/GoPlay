class ActivitiesController < ApplicationController

  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :admin_user


  def index
    @activities = Activity.all
  end


  def show
  end


  def new
    @activity = Activity.new
  end


  def edit
  end


  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html {
          flash[:success] = "Activity was successfully created."
          redirect_to activities_path
        }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html {
          flash[:success] = "Activity was successfully updated."
          redirect_to activities_path
        }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @activity.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Activity was successfully deleted."
        redirect_to activities_path
      }
      format.json { head :no_content }
    end
  end


  private


    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name)
    end


    # Confirms an admin user.
    def admin_user
      if !is_admin?
        flash[:danger] = 'You must be an admin to perform that function.'
        redirect_to(login_path)
      end
    end

end
