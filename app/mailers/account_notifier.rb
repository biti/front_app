class AccountNotifier < ActionMailer::Base
  default from: 'from@example.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_notifier.invite.subject
  #
  def invite(email, invt)
    @greeting = "Hi"
    @invt = invt

    mail to: email, subject: 'Invitation'
  end

  def authorize(email, auth)
    @greeting = "Hi"
    @auth = auth

    mail to: email, subject: 'Authorization'
  end

  def reset_password(email, auth)
    @greeting = "Hi"
    @auth = auth

    mail to: email, subject: 'Reset Password'
  end
end
