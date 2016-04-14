class EventsController < ApplicationController


  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]


  def search
    address = GeocodedAddress.new(params['user_geo'])
    # find events within the search radius, and filter on the chosen criteria
    @events = Event.within(params[:radius].to_i, :origin => [ address.latitude , address.longitude ])
                  .where('activity_id=?', params['activity_id'])
                  .where('start_date >= ?', DateTime.now)
                  .order('start_date')
                  .paginate(page: params[:page])
  end


  def get_event_types
    @event_types = EventType.where("activity_id = ?", params[:activity_id])
    respond_to do |format|
      format.js
    end
  end


  def index
    @events = Event.paginate(page: params[:page])
  end


  def show
  end


  def new
    @event = Event.new
  end


  def edit
    @event.start_date = @event.start_date.strftime("%m/%d/%Y")
  end


  def create
    @event = Event.new(event_params)
    @event.owner_id = current_user.id

    respond_to do |format|
      if @event.save

        if @event.is_urgent?
          client = Twilio::REST::Client.new(
              ENV["TWILIO_ACCOUNT_SID"],
              ENV["TWILIO_AUTH_TOKEN"]
          )

          subscribers = User.within(50, :origin => [@event.latitude, @event.longitude])
                            .where('receive_urgent_notifications=true')
                            .where('phone is not null')
                            .where('id in (select user_id from activities_users where activity_id = ' + @event.activity_id.to_s + ')')

          subscribers.each do |sub|
            client.messages.create(
                to: sub.phone,
                from: ENV["TWILIO_PHONE_NUMBER"],
                body: APP_NAME + " urgent notification -- " + @event.title + ". " + "Contact " + current_user.name + " at " + current_user.phone + "."
            )
          end
        end

        format.html {
          flash[:success] = "Event was successfully created."
          redirect_to root_path
        }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html {
          flash[:success] = "Event was successfully updated."
          redirect_to root_path
        }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @event.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Event was successfully deleted."
        redirect_to events_path
      }
      format.json { head :no_content }
    end
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:activity_id, :event_type_id, :venue_id, :title, :subtitle, :description, :details, :price, :restrictions, :info_url, :registration_url, :start_date, :start_time, :recurrence, :latitude, :longitude, :is_urgent)
  end


  def fix_date_format(raw_date_string)
    date_buffer = raw_date_string.split('/')
    return date_buffer[2] + '-' + date_buffer[0] + '-' + date_buffer[1]
  end


  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "You have to be a registered user to do that. It's easy to <a href='/signup' style='color:black;'>join</a>!"
      redirect_to login_url
    end
  end


end
