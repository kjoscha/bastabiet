require "test_helper"

class UpdateTest < Capybara::Rails::TestCase
  scenario 'update not possible if agreement not accepted', :js do
    log_in
    click_on 'Speichern'
    assert_content 'Bitte lies und bestätige die Vereinbarung'
  end

  scenario 'updates share if agreement is accepted', :js do
    log_in
    check 'share_agreed'
    fill_in 'share_offer_minimum', with: '70'
    click_on 'Speichern'
    assert_content 'Erfolgreich aktualisiert'
    @share.reload
    assert_equal true, @share.agreed
    assert_equal @share.offer_minimum, 70
  end

  def log_in
    add_valid_user(true)
    visit root_path
    fill_in 'Email', with: 'foo@bar.org'
    fill_in 'Passwort', with: 'secret'
    click_on "Ab geht's"
  end
end
