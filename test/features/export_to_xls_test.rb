require_relative '../test_helper'

class ExportToXlsTest < Capybara::Rails::TestCase
  scenario 'XLS Download link present and working', :js do
    enter_admin_area
    click_on 'Herunterladen als xls'

    assert_equal 'application/xls; charset=utf-8', page.response_headers['Content-Type']
  end
end
