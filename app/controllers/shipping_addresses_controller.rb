class ShippingAddressesController < ApplicationController
  layout 'subscribers'

  # GET /shipping_addresses
  # GET /shipping_addresses.json
  def index
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_addresses = @subscriber.shipping_addresses

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shipping_addresses }
    end
  end

  # GET /shipping_addresses/1
  # GET /shipping_addresses/1.json
  def show
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_address = @subscriber.shipping_addresses.find_by_id(params[:id])

    if @shipping_address
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @shipping_address }
      end
    else
      respond_to do |format|
        format.html { redirect_to :action => 'index' }
        format.json { render json: @shipping_address }
      end
    end
  end

  # GET /shipping_addresses/new
  # GET /shipping_addresses/new.json
  def new
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_address = @subscriber.shipping_addresses.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shipping_address }
    end
  end

  # GET /shipping_addresses/1/edit
  def edit
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_address = @subscriber.shipping_addresses.find_by_id(params[:id])
    redirect_to :action => 'index' unless @shipping_address
  end

  # POST /shipping_addresses
  # POST /shipping_addresses.json
  def create
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_address = @subscriber.shipping_addresses.new(params[:shipping_address])
    @shipping_address.region = Region.find_by_id(params[:district])

    respond_to do |format|
      if @shipping_address.save
        format.html { redirect_to @shipping_address, notice: 'Shipping address was successfully created.' }
        format.json { render json: @shipping_address, status: :created, location: @shipping_address }
      else
        format.html { render action: "new" }
        format.json { render json: @shipping_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shipping_addresses/1
  # PUT /shipping_addresses/1.json
  def update
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_address = @subscriber.shipping_addresses.find_by_id(params[:id])
    @shipping_address.region = Region.find_by_id(params[:district])

    respond_to do |format|
      if @shipping_address
        if @shipping_address.update_attributes(params[:shipping_address])
          format.html { redirect_to @shipping_address, notice: 'Shipping address was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @shipping_address.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to action: "index" }
        format.json { render json: @shipping_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_addresses/1
  # DELETE /shipping_addresses/1.json
  def destroy
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_address = @subscriber.shipping_addresses.find_by_id(params[:id])
    @shipping_address && @shipping_address.destroy

    respond_to do |format|
      format.html { redirect_to shipping_addresses_url }
      format.json { head :no_content }
    end
  end
end
