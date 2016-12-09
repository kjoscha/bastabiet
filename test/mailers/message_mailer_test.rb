require "test_helper"

class MessageMailerTest < ActionMailer::TestCase
  delegate :url_helpers, to: 'Rails.application.routes'

  def setup
    @station = Station.create(name: "test_station")
    @group = Group.create(station_id: @station.id, name: "test_group")
    @share = Share.create(group_id: @group.id,
                          name: "test share", 
                          payment: 1,
                          land_help_days: 3,
                          no_help: false,
                          skills: 'test_skills',
                          size: 2, 
                          password: "secret",
                          password_confirmation: "secret",
                          email: "foo@bar.org",
                          agreed: true)
  end

  test "Activation email" do
    mail = MessageMailer.activation_link(@share)

    assert_equal ['basta@lupus.uberspace.de'], mail.from
    assert_equal ['foo@bar.org'], mail.to
    assert_equal 'Bastabiet-Account aktivieren', mail.subject
    assert_match url_helpers.activate_share_url(id: @share.id, token: @share.activation_token), mail.body.encoded
    assert_match "Hallo", mail.body.encoded
  end

  test "Password reset email" do
    @share.create_digest_for(attribute: 'password_reset')
    mail = MessageMailer.send_password_reset_link(@share)

    assert_equal ['basta@lupus.uberspace.de'], mail.from
    assert_equal ['foo@bar.org'], mail.to
    assert_equal 'Password zurücksetzen für Bastabiet', mail.subject
    assert_match url_helpers.reset_password_url(id: @share.id, token: @share.password_reset_token), mail.body.encoded
    assert_match "Hallo", mail.body.encoded
  end
end
