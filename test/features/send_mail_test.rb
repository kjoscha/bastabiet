require "test_helper"

class SendMailTest < Capybara::Rails::TestCase
  before do
    visit root_path
    page.driver.basic_authorize('admin', 'secret')
    click_on 'Admin'
  end

  scenario 'send mail to selected shares', :js do
    share_id = Share.first.id
    find("input[value='#{share_id}']").click
    fill_in 'email_subject', with: 'Any subject'
    fill_in 'email_text', with: 'Any text'
    click_on 'Email senden'
    assert_content 'Email(s) erfolgreich gesendet!'
  end

  scenario 'does show error if no receivers selected', :js do
    fill_in 'email_subject', with: 'Any subject'
    fill_in 'email_text', with: 'Any text'
    click_on 'Email senden'
    assert_content 'Keine Empfänger_innen ausgewählt!'
  end

  scenario 'does show error if text or subject missing', :js do
    share_id = Share.first.id
    find("input[value='#{share_id}']").click
    click_on 'Email senden'
    assert_content 'Betreff und Text dürfen nicht leer sein!'
  end
end
