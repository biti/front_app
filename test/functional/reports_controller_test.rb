require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @subscriber = subscribers(:tsai)
    @report = reports(:one)
    FileUtils.copy("test/fixtures/t.jpg", Rails.configuration.resources_dir)
    session[:subscriber_id] = @subscriber.id
  end

  teardown do
    FileUtils.remove(File.join(Rails.configuration.resources_dir, "t.jpg"))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test "should get new no product" do
    get :new
    assert_response :success
  end

  test "should get new" do
    get :new, :product => 1
    assert_response :success
  end

  test "should create report" do
    assert_difference('Report.count') do
      post :create, report: { receipt_date: @report.receipt_date, receipt_photo: "t.jpg", receipt_price: @report.receipt_price, retailer: @report.retailer }, product: 1
    end

    assert_redirected_to report_path(assigns(:report))
  end

  test "should show report" do
    get :show, id: @report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report
    assert_response :success
  end

  test "should update report" do
    put :update, id: @report, report: { receipt_date: @report.receipt_date, receipt_photo: "t.jpg", receipt_price: @report.receipt_price, retailer: @report.retailer }
    assert_redirected_to report_path(assigns(:report))
  end

  test "should destroy report" do
    assert_difference('Report.count', -1) do
      delete :destroy, id: @report
    end

    assert_redirected_to reports_path
  end
end
