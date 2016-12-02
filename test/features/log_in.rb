require "test_helper"

class LogIn < Capybara::Rails::TestCase
  scenario 'start page working', :js do
    add_valid_user
    visit root_path
    fill_in 'Email', with: 'foo@bar.org'
    fill_in 'Passwort', with: 'secret'
    click_on "Ab geht's"
    assert_content 'Pflichtangaben'
    assert_equal 'test_skills', find_field('share_skills').value
    %w[minimum medium maximum].each do |m|
      assert_empty find_field("share_offer_#{m}").value
    end
  end

  def add_valid_user
    @group = groups(:Bouffe)
    @share = Share.create(group_id: @group.id,
                          name: "test share", 
                          members: "some test persons in this share",
                          payment: 1,
                          land_help_days: 3,
                          workgroup: 'test_work_group',
                          no_help: false,
                          skills: 'test_skills',
                          size: 2, 
                          password: "secret",
                          password_confirmation: "secret",
                          email: "foo@bar.org",
                          agreed: true,
                          activated: true,
                          )
  end
end
