require 'test_helper'

class Admin::LandingPagesControllerTest < ActionController::TestCase
  setup do
    @operator = admin_operators(:admin)
    @landing_page = admin_landing_pages(:one)
    FileUtils.copy("test/fixtures/t.jpg", Rails.configuration.resources_dir)
    session[:operator_id] = @operator.id
  end

  teardown do
    FileUtils.remove(File.join(Rails.configuration.resources_dir, "t.jpg"))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:landing_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create landing_page" do
    assert_difference('Admin::LandingPage.count') do
      post :create, admin_landing_page: { :domain => "*", :background_image => "t.jpg" }
    end

    assert_redirected_to admin_landing_page_path(assigns(:landing_page))
  end

  test "should show landing_page" do
    get :show, id: @landing_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @landing_page
    assert_response :success
  end

  test "should update landing_page" do
    put :update, id: @landing_page, admin_landing_page: { :domain => "*", :background_image => "t.jpg" }
    assert_redirected_to admin_landing_page_path(assigns(:landing_page))
  end

  test "should destroy landing_page" do
    assert_difference('Admin::LandingPage.count', -1) do
      delete :destroy, id: @landing_page
    end

    assert_redirected_to admin_landing_pages_path
  end
end
