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
    fill_in 'share_offer_minimum', with: '10'
    fill_in 'share_offer_maximum', with: '80'
    select '1.5', from: 'share_size'
    click_on 'Speichern'
    assert_content 'Erfolgreich aktualisiert'
    @share.reload
    assert_equal true, @share.agreed
    assert_equal 10, @share.offer_minimum
    assert_equal 80, @share.offer_medium
    assert_equal 80, @share.offer_maximum
    assert_equal '10.0', find('#share_offer_minimum').value
    assert_equal '80.0', find('#share_offer_medium').value
    assert_equal '80.0', find('#share_offer_maximum').value
  end

  scenario 'can add and remove members', :js do
    log_in
    fill_in 'member_name', with: 'Member name'
    fill_in 'member_email', with: 'test@member.com'
    fill_in 'member_telephone', with: '1234'
    click_on 'Mitglied hinzufügen'
    refute_content 'Nicht erlaubt!'
    assert_content 'Member name'
    click_on 'Löschen'
    refute_content 'Member name'
  end

  scenario 'can change workgroups', :js do
    @internet_ag_checkbox = "share_workgroup_ids_#{workgroups(:InternetAG).id}"
    @finanz_ag_checkbox = "share_workgroup_ids_#{workgroups(:FinanzAG).id}"
    log_in
    check 'share_agreed'
    check @internet_ag_checkbox
    click_on 'Speichern'
    assert_equal 1, @share.workgroups.count
    has_checked_field? @internet_ag_checkbox
    !has_checked_field? @finanz_ag_checkbox
  end

  def log_in
    add_valid_user(true)
    visit root_path
    fill_in 'Email der Hauptkontaktperson', with: 'foo@bar.org'
    fill_in 'Passwort', with: 'secret'
    click_on "Ab geht's"
  end
end
