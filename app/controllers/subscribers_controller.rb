require 'b64_uuid'

class SubscribersController < ApplicationController

  skip_before_filter :authorize, :only => [ :finish_authorizing_email ]

  def home
    @subscriber = Subscriber.find(session[:subscriber_id])
  end

  def invite
    @code = get_invitation_code
    render :layout => 'application'
  end

  def deliver
    code = get_invitation_code
    params[:email].each do
      | each |

      if each =~ /\b[[:alnum:]._%-]+@[[:alnum:].-]+\.[[:alpha:]]{2,4}\b/ &&
          Subscriber.find_by_email(each).nil?
        AccountNotifier.invite(each, (sign_up_url :invitation => code)).deliver
      end
    end
    redirect_to :action => 'invite'
  end

  def initiate_authorizing_email
    code = get_authorization_code
    AccountNotifier.authorize(@subscriber.email, (authorize_url :q => code)).deliver
  end

  def finish_authorizing_email
    auth = Authorization.find_by_code(params[:q])
    unless auth.nil? || auth.expired? || auth.email != auth.subscriber.email
      auth.subscriber.detail ||= SubscriberDetail.new
      auth.subscriber.detail.email_authorized_at = Time.now
      auth.subscriber.detail.save
      @subscriber = auth.subscriber
    end
    render :layout => 'application'
  end

  def edit
    @subscriber = Subscriber.find(session[:subscriber_id])
  end

  def password
    @subscriber = Subscriber.find(session[:subscriber_id])
  end

  def payment_password
    @subscriber = Subscriber.find(session[:subscriber_id])
  end

  def update
    @subscriber = Subscriber.find(session[:subscriber_id])
    if @subscriber.update_attributes params[:subscriber]
      redirect_to :action => 'edit'
    else
      render :action => 'edit'
    end
  end

  def update_password
    @subscriber = Subscriber.find(session[:subscriber_id])
    if @subscriber.authenticate(params[:old]) &&
        params[:confirm] == params[:new]
      @subscriber.password = params[:new]
      if @subscriber.save
        redirect_to :action => 'password'
        return
      end
    end
    render :action => 'password'
  end

  def update_payment_password
    @subscriber = Subscriber.find(session[:subscriber_id])
    @subscriber.detail ||= SubscriberDetail.new
    if (@subscriber.detail.payment_password.nil? ||
        @subscriber.detail.payment_authenticate(params[:old])) &&
        params[:confirm] == params[:new]
      @subscriber.detail.payment_password = params[:new]
      if @subscriber.detail.save
        redirect_to :action => 'payment_password'
        return
      end
    end
    render :action => 'payment_password'
  end

  # ------------------------------------------------------------
  private

  def get_invitation_code
    @subscriber = Subscriber.find(session[:subscriber_id])
    if @subscriber.invitations.empty?
      invt = @subscriber.invitations.new
      invt.code = B64UUID.generate
      invt.save
    end
    @subscriber.invitations.last.code
  end

  def get_authorization_code
    @subscriber = Subscriber.find(session[:subscriber_id])
    @subscriber.authorization ||= Authorization.new
    @subscriber.authorization.code = B64UUID.generate
    @subscriber.authorization.email = @subscriber.email
    @subscriber.authorization.expire_at = Time.now + 3600 # TODO: authorization_ttl
    @subscriber.authorization.save
  end

end
