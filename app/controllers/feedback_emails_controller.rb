class FeedbackEmailsController < ApplicationController


  def new
    @feedback_email = FeedbackEmail.new
    @feedback_email.name = current_user.name unless current_user.nil?
    @feedback_email.email = current_user.email unless current_user.nil?
  end


  def create
    @feedback_email = FeedbackEmail.new(feedback_email_params)

    if @feedback_email.valid?
      UserMailer.feedback_email(@feedback_email).deliver_now
      flash[:success] = "Thank you! An email has been sent to the boss with your feedback."
      redirect_to root_url
    else
      render 'new'
    end
  end


  private


  # Never trust parameters from the scary internet, only allow the white list through.
  def feedback_email_params
    params.require(:feedback_email).permit(:name, :email, :message)
  end


end
