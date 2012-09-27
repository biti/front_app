class Admin::ComplaintsController < Admin::AdminController

  def index
    @complaints = Complaint.page(params[:page]).order("created_at DESC")
  end

  def show
    @complaint = Complaint.find(params[:id])
  end

  def edit
    @complaint = Complaint.find(params[:id])
    redirect_to admin_complaint_url(@complaint) if @complaint.finished_at
  end

  def accept
    @complaint = Complaint.find(params[:id])
    @complaint.accept
    @complaint.save
    redirect_to admin_complaint_url(@complaint)
  end

  def finish
    @complaint = Complaint.find(params[:id])
    @complaint.remark = params[:complaint][:remark]
    @complaint.finish
    @complaint.save
    redirect_to admin_complaint_url(@complaint)
  end

end
