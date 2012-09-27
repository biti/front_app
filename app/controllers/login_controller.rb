class LoginController < ApplicationController

  skip_before_filter :authorize, :only => [ :sign_up, :sign_in, :sign_out, :create, :authenticate, :check ]

  include ApplicationHelper
  include LoginHelper

  def sign_up
    @subscriber = Subscriber.new
    @background_image = resource_url background_image.to_s
  end

  def sign_in
    @subscriber = Subscriber.new
    @subscriber.email = params[:email]
    @background_image = resource_url background_image.to_s
  end

  def sign_out
    session.delete :subscriber_id
    redirect_to :action => "sign_up"
  end

  def initiate_reset_password
  end

  def deliver_reset_password
    @subscriber = Subscriber.find_by_email(params[:email])
    if @subscriber
      code = get_authorization_code
      AccountNotifier.reset_password(@subscriber.email, (reset_password_code_url code)).deliver
    else
      redirect_to :action => "initiate_reset_password" unless @subscriber
    end
  end

  def reset_password
  end

  def finish_reset_password
    auth = Authorization.find_by_code(params[:code])
    if auth.nil? || auth.expired?
      redirect_to :action => "initiate_reset_password"
    elsif params[:new].empty? || params[:confirm] != params[:new]
      redirect_to :action => "reset_password", :code => params[:code]
    else
      auth.subscriber.password = params[:new]
      auth.subscriber.save
      session[:subscriber_id] = auth.subscriber.id
      redirect_to home_path
    end
  end

  def create
    invt = Invitation.find_by_code(params[:invitation])
    @subscriber = Subscriber.new(:email => params[:subscriber][:email])
    @subscriber.password = params[:subscriber][:password]
    @subscriber.initiator = invt && invt.subscriber
    @subscriber.save

    session[:subscriber_id] = @subscriber.id
    redirect_to :controller => "subscribers", :action => "home"
  end

  def authenticate
    @subscriber = Subscriber.find_by_email(params[:subscriber][:email])
    if @subscriber.nil?
      redirect_to :action => "sign_up"
    elsif @subscriber.authenticate(params[:subscriber][:password])
      session[:subscriber_id] = @subscriber.id
      redirect_to :controller => "subscribers", :action => "home"
    else
      redirect_to :action => "sign_in"
    end
  end

  def check
    respond_to do | format |
      format.json { render json: { :new => Subscriber.find_by_email(params[:subscriber][:email]).nil? } }
    end
  end

  # ------------------------------------------------------------
  private

  def get_authorization_code
    @subscriber.authorization ||= Authorization.new
    @subscriber.authorization.code = B64UUID.generate
    @subscriber.authorization.email = @subscriber.email
    @subscriber.authorization.expire_at = Time.now + 3600 # TODO: authorization_ttl
    @subscriber.authorization.save
  end

end
