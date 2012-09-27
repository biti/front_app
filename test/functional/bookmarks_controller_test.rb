require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  setup do
    @subscriber = subscribers(:tsai)
    @bookmark = bookmarks(:one)
    session[:subscriber_id] = @subscriber.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmarks)
  end

  test "should create bookmark" do
    assert_difference('Bookmark.count') do
      post :create, :product => 1
    end

    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  test "should show bookmark" do
    get :show, id: @bookmark
    assert_response :success
  end

  test "should destroy bookmark" do
    assert_difference('Bookmark.count', -1) do
      delete :destroy, id: @bookmark
    end

    assert_redirected_to bookmarks_path
  end
end
