require 'test_helper'

class Admin::AnnouncementsControllerTest < ActionController::TestCase
  setup do
    @operator = admin_operators(:admin)
    @admin_announcement = admin_announcements(:one)
    session[:operator_id] = @operator.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_announcements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_announcement" do
    assert_difference('Admin::Announcement.count') do
      post :create, admin_announcement: { :title => "The Tao Of Programming", :content => "A novice asked the Master: ``Here is a programmer that never designs, documents or tests his programs. Yet all who know him consider him one of the best programmers in the world. Why is this?''" }
    end

    assert_redirected_to admin_announcement_path(assigns(:admin_announcement))
  end

  test "should show admin_announcement" do
    get :show, id: @admin_announcement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_announcement
    assert_response :success
  end

  test "should update admin_announcement" do
    put :update, id: @admin_announcement, admin_announcement: { :title => "The Tao Of Programming", :content => "The Master replies: ``That programmer has mastered the Tao. He has gone beyond the need for design; he does not become angry when the system crashes, but accepts the universe without concern. He has gone beyond the need for documentation; he no longer cares if anyone else sees his code. He has gone beyond the need for testing; each of his programs are perfect within themselves, serene and elegant, their purpose self-evident. Truly, he has entered the mystery of Tao.''" }
    assert_redirected_to admin_announcement_path(assigns(:admin_announcement))
  end

  test "should destroy admin_announcement" do
    assert_difference('Admin::Announcement.count', -1) do
      delete :destroy, id: @admin_announcement
    end

    assert_redirected_to admin_announcements_path
  end
end
