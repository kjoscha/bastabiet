require "test_helper"

class AdminAreaSecured < Capybara::Rails::TestCase
  scenario 'start page working' do
    visit root_path
    assert_content 'CSA BASTA'
  end

  scenario 'admin area not accessible working without authentication', :js do
    visit root_path
    click_on 'Admin'
    refute_content 'Nur Bezugsgruppen'
  end

  scenario 'admin area accessible with authentication', :js do
    visit root_path
    page.driver.basic_authorize('admin', 'secret')
    click_on 'Admin'
    assert_content 'Nur Bezugsgruppen'
  end
end
