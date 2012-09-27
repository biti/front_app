class NotificationsController < ApplicationController
  layout "subscribers"

  def index
    @subscriber = Subscriber.find(session[:subscriber_id])
    @notifications = @subscriber.notifications.where(:state => [ Notification::NEW, Notification::READ ]).page(params[:page]).order("created_at DESC")
  end

  def show
    @subscriber = Subscriber.find(session[:subscriber_id])
    @notification = @subscriber.notifications.find(params[:id])
    @notification.read
  end

  def read
    @subscriber = Subscriber.find(session[:subscriber_id])
    @notification = @subscriber.notifications.find(params[:id])
    @notification.read
    redirect_to :action => "index"
  end

  def stash
    @subscriber = Subscriber.find(session[:subscriber_id])
    @notification = @subscriber.notifications.find(params[:id])
    @notification.stash
    redirect_to :action => "index"
  end
end
