ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest/rails/capybara'
require 'capybara/poltergeist'
require 'capybara-screenshot/minitest'

def validate_captcha
  fill_in 'captcha', with: SimpleCaptcha::SimpleCaptchaData.first.value
end

def login
  visit login_path
  fill_in 'sessions_email', with: 'admin@example.com'
  fill_in 'sessions_password', with: 'secret'
  click_on 'Login'
end

reporter_options = { color: true }
Minitest::Reporters.use!(
  # Minitest::Reporters::DefaultReporter.new(reporter_options),
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter)

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  config.include Rails.application.routes.url_helpers
end

# While testing with Javascript flag, test runs in another thread,
# thus created fixtures are not available without the following setup
class Capybara::Rails::TestCase
  self.use_transactional_fixtures = false

  before do
    if metadata[:js]
      Capybara.javascript_driver = :poltergeist
      Capybara.current_driver = Capybara.javascript_driver
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start
    end
  end

  after do
    if metadata[:js]
      DatabaseCleaner.clean
    end

    Capybara.reset_sessions!
    Capybara.current_driver = Capybara.default_driver
  end
end

def add_valid_user(activated)
  @group = groups(:Bouffe)
  @share = Share.create(group_id: @group.id,
                        name: "test share", 
                        payment: 1,
                        land_help_days: 3,
                        no_help: false,
                        skills: 'test_skills',
                        size: 2, 
                        password: "secret",
                        password_confirmation: "secret",
                        email: "foo@bar.org",
                        agreed: false,
                        activated: activated,
                        )
end

def saoi
  screenshot_and_open_image
end
