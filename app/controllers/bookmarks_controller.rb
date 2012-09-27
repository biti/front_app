class BookmarksController < ApplicationController
  layout "subscribers"

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmarks }
    end
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark }
    end
  end

  # POST /bookmarks
  def create
    @subscriber = Subscriber.find(session[:subscriber_id])
    @product = Product.find_by_id(params[:product])
    if @product
      @bookmark = @subscriber.bookmarks.find_by_product_id(@product)
      if @bookmark.nil?
        @bookmark = @subscriber.bookmarks.new
        @bookmark.product = @product
        @bookmark.save
      end

      redirect_to @bookmark, notice: 'Bookmark was successfully created.'
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to bookmarks_url }
      format.json { head :no_content }
    end
  end
end
