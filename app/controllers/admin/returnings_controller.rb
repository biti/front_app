class Admin::ReturningsController < Admin::AdminController

  def index
    @returnings = Returning.page(params[:page])
  end

  def show
    @returning = Returning.find(params[:id])
  end

  def accept
    @returning = Returning.find(params[:id])
    redirect_to admin_returning_url(@returning) if (@returning.settled_at ||
                                                    @returning.accepted_at)
  end

  def solve
    @returning = Returning.find(params[:id])
    redirect_to admin_returning_url(@returning) if (@returning.settled_at ||
                                                    @returning.delivered_at.nil?)
  end

  def reject
    @returning = Returning.find(params[:id])
    redirect_to admin_returning_url(@returning) if (@returning.settled_at ||
                                                    @returning.accepted_at)
  end

  def do_accept
    @returning = Returning.find(params[:id])
    @returning.accept(params[:returning][:amount])
    @returning.save
    redirect_to admin_returning_url(@returning)
  end

  def do_solve
    @returning = Returning.find(params[:id])
    # TODO:
    @returning.solve(params[:returning][:remark])
    @returning.save
    redirect_to admin_returnings_url
  end

  def do_reject
    @returning = Returning.find(params[:id])
    @returning.reject(params[:returning][:remark])
    @returning.save
    redirect_to admin_returnings_url
  end

end
