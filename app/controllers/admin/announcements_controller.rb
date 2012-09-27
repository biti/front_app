class Admin::AnnouncementsController < Admin::AdminController
  # GET /admin/announcements
  # GET /admin/announcements.json
  def index
    @admin_announcements = Admin::Announcement.page(params[:page]).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_announcements }
    end
  end

  # GET /admin/announcements/1
  # GET /admin/announcements/1.json
  def show
    @admin_announcement = Admin::Announcement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_announcement }
    end
  end

  # GET /admin/announcements/new
  # GET /admin/announcements/new.json
  def new
    @admin_announcement = Admin::Announcement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_announcement }
    end
  end

  # GET /admin/announcements/1/edit
  def edit
    @admin_announcement = Admin::Announcement.find(params[:id])
  end

  # POST /admin/announcements
  # POST /admin/announcements.json
  def create
    @admin_announcement = Admin::Announcement.new(params[:admin_announcement])

    respond_to do |format|
      if @admin_announcement.save
        format.html { redirect_to @admin_announcement, notice: 'Announcement was successfully created.' }
        format.json { render json: @admin_announcement, status: :created, location: @admin_announcement }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/announcements/1
  # PUT /admin/announcements/1.json
  def update
    @admin_announcement = Admin::Announcement.find(params[:id])

    respond_to do |format|
      if @admin_announcement.update_attributes(params[:admin_announcement])
        format.html { redirect_to @admin_announcement, notice: 'Announcement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/announcements/1
  # DELETE /admin/announcements/1.json
  def destroy
    @admin_announcement = Admin::Announcement.find(params[:id])
    @admin_announcement.destroy

    respond_to do |format|
      format.html { redirect_to admin_announcements_url }
      format.json { head :no_content }
    end
  end
end
