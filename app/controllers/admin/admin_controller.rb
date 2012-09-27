module Admin

  class AdminController < ActionController::Base
    protect_from_forgery
    layout 'admin'

    before_filter :authorize

    # ------------------------------------------------------------
    protected

    def authorize
      unless Operator.find_by_id(session[:operator_id])
        redirect_to admin_sign_in_path
      end
    end
  end

end
