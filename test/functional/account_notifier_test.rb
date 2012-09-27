require 'test_helper'

class AccountNotifierTest < ActionMailer::TestCase
  test "invite" do
    mail = AccountNotifier.invite "to@example.com", ""
    assert_equal "Invitation", mail.subject
    assert_equal ["to@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "authorize" do
    mail = AccountNotifier.authorize "to@example.com", ""
    assert_equal "Authorization", mail.subject
    assert_equal ["to@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
