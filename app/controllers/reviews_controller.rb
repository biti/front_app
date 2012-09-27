class ReviewsController < ApplicationController
  layout "subscribers"

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = @subscriber.reviews.page(params[:page]).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  def new
    product = Product.find_by_id(params[:product])
    if product
      if review = @subscriber.reviews.find_by_product_id(product.id)
        redirect_to (edit_review_path review)
      else
        @review = @subscriber.reviews.new
        @review.product = product
      end
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = @subscriber.reviews.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = @subscriber.reviews.new(params[:review])
    @review.product = Product.find_by_id(params[:product])

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = @subscriber.reviews.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = @subscriber.reviews.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end
end
