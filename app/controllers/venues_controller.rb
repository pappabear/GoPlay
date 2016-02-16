class VenuesController < ApplicationController


  before_action :admin_user
  before_action :set_venue, only: [:show, :edit, :update, :destroy]


  def index
    @venues = Venue.paginate(page: params[:page])
  end


  def show
  end


  def new
    @venue = Venue.new
  end


  def edit
  end


  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html {
          flash[:success] = "Venue was successfully created."
          redirect_to venues_path
        }
        format.json { render :show, status: :created, location: @venue }
      else
        puts '-----------------------------------------------------'
        puts @venue.errors.count.to_s + ' ERROR(S) CAUGHT HERE, in Venue.create()'
        if @venue.errors.any?
            @venue.errors.full_messages.each do |msg|
              puts '-' + msg
            end
        end
        puts '-----------------------------------------------------'

        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html {
          flash[:success] = "Venue was successfully updated."
          redirect_to venues_path
        }
        format.json { render :show, status: :ok, location: @venue }
      else

        puts '-----------------------------------------------------'
        puts @venue.errors.count.to_s + ' ERROR(S) CAUGHT HERE, in Venue.update()'
        if @venue.errors.any?
          @venue.errors.full_messages.each do |msg|
            puts '-' + msg
          end
        end
        puts '-----------------------------------------------------'

        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @venue.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Venue was successfully deleted."
        redirect_to venues_path
      }
      format.json { head :no_content }
    end
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def venue_params
    params.require(:venue).permit(:name, :address1, :address2, :city, :state, :zip, :phone, :longitude, :latitude)
  end


  # Confirms an admin user.
  def admin_user
    if !is_admin?
      flash[:danger] = 'You must be an admin to perform that function.'
      redirect_to(login_path)
    end
  end


end
