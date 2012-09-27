module Admin

  class LoginController < AdminController

    skip_before_filter :authorize, :only => [ :sign_in, :sign_out, :authenticate ]

    def sign_in
      @operator = Operator.new
    end

    def sign_out
      session.delete :operator_id
      redirect_to :action => 'sign_in'
    end

    def authenticate
      @operator = Operator.find_by_username(params[:admin_operator][:username])
      @operator &&= @operator.authenticate(params[:admin_operator][:password])
      if @operator
        session[:operator_id] = @operator.id
        redirect_to :controller => 'landing_pages', :action => 'index'
      else
        redirect_to :action => 'sign_in'
      end
    end

  end

end
