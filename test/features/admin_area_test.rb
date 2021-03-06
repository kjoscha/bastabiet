require "test_helper"

class AdminAreaTest < Capybara::Rails::TestCase
  scenario 'start page working' do
    visit root_path
    assert_content 'CSA BASTA'
  end

  scenario 'admin area not accessible working without authentication', :js do
    visit root_path
    click_on 'Admin'
    refute_content 'Ernteanteile'
  end

  scenario 'admin area correct and accessible with authentication', :js do
    add_valid_user(true)
    visit root_path
    @share.update_attributes(
      offer_minimum: 10,
      offer_medium: 50,
      offer_maximum: 100,
      size: 2
    )
    page.driver.basic_authorize('admin', 'secret')
    click_on 'Admin'
    assert_content 'Ernteanteile'
    assert_content '10€'
    assert_content '50€'
    assert_content '100€'
  end
end
