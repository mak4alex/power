require 'test_helper'

class HelpMailerTest < ActionMailer::TestCase
  test "demand" do
    mail = HelpMailer.demand
    assert_equal "Demand", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
