require "test_helper"

class RegisterTest < Capybara::Rails::TestCase
  scenario 'register new share', :js do
    visit register_path
    select 'Bouffe', from: 'share_group_id'
    select '1.0', from: 'share_size'
    fill_in 'share_name', with: 'Peter Silie'
    fill_in 'share_email', with: 'foo@bar.org'
    fill_in 'share_telephone', with: '030-817263549'
    fill_in 'share_password', with: 'secret'
    fill_in 'share_password_confirmation', with: 'secret'
    click_on "Ab geht's"
    assert_content 'erfolgreich angelegt'
  end
end
