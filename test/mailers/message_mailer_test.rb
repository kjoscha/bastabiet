require "test_helper"

class MessageMailerTest < ActionMailer::TestCase
  delegate :url_helpers, to: 'Rails.application.routes'

  def setup
    @station = Station.create(name: "test_station")
    @group = Group.create(station_id: @station.id, name: "test_group")
    @share = Share.create(group_id: @group.id,
                          name: "test share", 
                          members: "some test persons in this share",
                          payment: 1,
                          land_help_days: 3,
                          workgroup: 'test_work_group',
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

    assert_equal ['noreply@lpkb.menkent.uberspace.de'], mail.from
    assert_equal ['foo@bar.org'], mail.to
    assert_equal 'Bastabiet-Account aktivieren', mail.subject
    assert_match url_helpers.activate_share_url(id: @share.id, token: @share.activation_token), mail.body.encoded
    assert_match "Hallo", mail.body.encoded
  end
end
