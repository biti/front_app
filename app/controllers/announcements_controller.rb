require "admin"

class AnnouncementsController < ApplicationController
  layout "subscribers"

  def index
    @announcements = Admin::Announcement.page(params[:page]).order('created_at DESC')
  end

  def show
    @announcement = Admin::Announcement.find(params[:id])
  end
end
