class Admin::NotificationsController < Admin::AdminController

  def index
    @notifications = Notification.includes(:to).page(params[:page]).order('created_at DESC')
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(:content => params[:notification][:content])
    @notification.to = Subscriber.find_by_email(params[:notification][:to])
    if @notification.save
      redirect_to admin_notification_url(@notification), :notice => "Notification was successfully created."
    else
      render :action => "new"
    end
  end

end
