class Admin::ReportsController < Admin::AdminController

  def index
    @reports = Report.page(params[:page]).order('created_at DESC')
  end

  def show
    @report = Report.find(params[:id])
  end

  def accept
    @report = Report.find(params[:id])
    @report.accept
    @report.save
    redirect_to admin_report_url(@report)
  end

  def finish
    @report = Report.find(params[:id])
    @report.finish
    @report.save
    redirect_to admin_report_url(@report)
  end

end
