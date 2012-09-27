class ReturningsController < ApplicationController
  layout "subscribers"

  def index
    @returnings = @subscriber.returnings.page(params[:page])
  end

  def new
    @returning = @subscriber.returnings.new
    @returning.product = Product.find_by_id(params[:product])
    # TODO: order / product
  end

  def show
    @returning = @subscriber.returnings.find(params[:id])
  end

  def edit
    @returning = @subscriber.returnings.find(params[:id])
    redirect_to @returning unless (@returning.accepted_at &&
                                   @returning.delivered_at.nil?)
  end

  def create
    @returning = @subscriber.returnings.new
    @returning.product = Product.find_by_id(params[:product])
    @returning.quantity = params[:returning][:quantity]
    @returning.cause = params[:returning][:cause]

    if @returning.save
      redirect_to @returning, notice: 'Returning was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @returning = @subscriber.returnings.find(params[:id])
    @returning.deliver(params[:returning][:deliverer],
                       params[:returning][:tracking_no])
    if @returning.save
      redirect_to @returning, notice: 'Returning was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @returning = @subscriber.returnings.find(params[:id])
    @returning.cancel
    @returning.save
    redirect_to returnings_url
  end

end
