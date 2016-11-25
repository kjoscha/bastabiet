# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview

  def activation_link
    @station = Station.create(name: "test_station")
    @group = Group.create(station_id: @station.id, name: "test_group")
    @share = Share.create(group_id: @group.id, name: "test_share", size: 4, password: "secret", password_confirmation: "secret", email: "foo@bar.org")
    MessageMailer.activation_link(@share)
  end

end
