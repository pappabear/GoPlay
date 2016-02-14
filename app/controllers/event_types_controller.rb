class EventTypesController < ApplicationController


  before_action :set_event_type, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: :destroy


  def new
    @event_type = EventType.new
    @activity = Activity.find(params[:activity_id])
  end


  def create
    @event_type = EventType.new(event_type_params)
    @event_type.activity_id = params[:activity_id]
    @activity = Activity.find(params[:activity_id])

    respond_to do |format|
      if @event_type.save
        format.html {
          flash[:success] = 'Event type was successfully created.'
          redirect_to @activity
        }
        format.json { render :show, status: :created, location: @event_type }
      else
        format.html { render :new }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @event_type.update(event_type_params)
        format.html {
          flash[:success] = 'Event type was successfully updated.'
          redirect_to @activity
        }
        format.json { render :show, status: :ok, location: @event_type }
      else
        format.html { render :edit }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @event_type.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'Event type was successfully deleted.'
        redirect_to @activity
      }
      format.json { head :no_content }
    end
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_event_type
    @event_type = EventType.find(params[:id])
    @activity = Activity.find(params[:activity_id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def event_type_params
    params.require(:event_type).permit(:activity_id, :name)
  end


  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end
