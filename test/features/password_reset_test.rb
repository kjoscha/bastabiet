require 'test_helper'

feature 'Password reset' do
  before do
    Share.destroy_all
    @station = Station.create(name: "test_station")
    @group = Group.create(station_id: @station.id, name: "test_group")
    @activated_share = Share.create(group_id: @group.id,
                                    name: "foo bar",
                                    payment: 1,
                                    land_help_days: 3,
                                    no_help: false,
                                    skills: 'test_skills',
                                    size: 2,
                                    password: "secret",
                                    password_confirmation: "secret",
                                    email: "foo@bar.org",
                                    telephone: '123456789',
                                    activated: true,
                                    agreed: true)
  end

  scenario 'Can request password reset and creates digest' do
    visit request_password_reset_path
    fill_in 'password_reset_email', with: @activated_share.email
    click_on 'Passwort zurücksetzen'

    @activated_share.reload
    assert @activated_share.password_reset_digest
  end

  scenario 'Valid token can reset password' do
    visit request_password_reset_path
    fill_in 'password_reset_email', with: @activated_share.email
    click_on 'Passwort zurücksetzen'
  end
end
