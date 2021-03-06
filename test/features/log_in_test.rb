require "test_helper"

class LogInTest < Capybara::Rails::TestCase
  scenario 'login possible for activated shares', :js do
    log_in
    assert_content 'Pflichtangaben'
    assert_equal 'test_skills', find_field('share_skills').value
    %w[minimum medium maximum].each do |m|
      assert_empty find_field("share_offer_#{m}").value
    end
    click_on 'CSA BASTA'
    refute_content 'Anmelden'
    assert_content 'Pflichtangaben'
  end

  scenario 'login not possible for unregistered shares', :js do
    add_valid_user(false)
    visit root_path
    fill_in 'Email der Hauptkontaktperson', with: 'foo@bar.org'
    fill_in 'Passwort', with: 'secret'
    click_on "Ab geht's"
    assert_content 'Account noch nicht aktiviert'
  end

  scenario 'login not possible with wrong Email', :js do
    add_valid_user(true)
    visit root_path
    fill_in 'Email der Hauptkontaktperson', with: 'wrong@password.org'
    fill_in 'Passwort', with: 'secret'
    click_on "Ab geht's"
    assert_content 'Emailadresse nicht registriert'
  end


  scenario 'login not possible with wrong password', :js do
    add_valid_user(true)
    visit root_path
    fill_in 'Email der Hauptkontaktperson', with: 'foo@bar.org'
    fill_in 'Passwort', with: 'wrong'
    click_on "Ab geht's"
    assert_content 'Ungültiges Passwort'
  end

  scenario 'login not possible without credentials', :js do
    add_valid_user(true)
    visit root_path
    click_on "Ab geht's"
    refute_content 'Pflichtangaben'
  end

  def log_in
    add_valid_user(true)
    visit root_path
    fill_in 'Email der Hauptkontaktperson', with: 'foo@bar.org'
    fill_in 'Passwort', with: 'secret'
    click_on "Ab geht's"
  end
end
