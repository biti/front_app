class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  # ------------------------------------------------------------
  protected

  def authorize
    unless @subscriber = Subscriber.find_by_id(session[:subscriber_id])
      redirect_to sign_up_path
    end
  end
  
end
