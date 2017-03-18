require "test_helper"

class SettingsTest < Capybara::Rails::TestCase
  scenario 'Users cannot see statistics link when option is false', :js do
    log_in
    refute_content 'Statistik'
  end

  scenario 'Users can see statistics when option is true', :js do
    Setting.first.update!(show_statistics: true)
    visit root_path
    assert_content 'Statistik'
    find('.statistic-button').trigger('click')
    sleep(1)
    assert_content 'Statistik'
  end

  scenario 'Offer input fields stay active when no offers are present', :js do
    Setting.first.update!(offer_minimum_active: false)
    Setting.first.update!(offer_medium_active: true)
    Setting.first.update!(offer_maximum_active: false)
    log_in
    assert find_field('share_offer_minimum', disabled: false)
    assert find_field('share_offer_medium', disabled: false)
    assert find_field('share_offer_maximum', disabled: false)
  end

  scenario 'Offer inputs are inactive when they are disabled in settings', :js do
    Setting.first.update!(offer_minimum_active: false)
    log_in
    fill_in 'share_offer_minimum', with: '10'
    check 'share_agreed'
    click_on 'Speichern'
    saoi
    assert find_field('share_offer_minimum', disabled: true)
  end

  def log_in
    add_valid_user(true)
    visit root_path
    fill_in 'Email der Hauptkontaktperson', with: 'foo@bar.org'
    fill_in 'Passwort', with: 'secret'
    click_on "Ab geht's"
  end
end
