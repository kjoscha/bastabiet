require 'test_helper'

class PasswordResetControllerTest < ActionController::TestCase
  def setup
    @station = Station.create(name: "test_station")
    @group = Group.create(station_id: @station.id, name: "test_group")
    @activated_share = add_valid_user(false)
  end

  test "Can request password reset" do
    get :request_password_reset
    assert_response :success
  end

  test "Shall create new password reset digest for existing account" do
    post :create_password_reset, password_reset: { email: 'foo@bar.org' }
    @activated_share.reload

    assert @activated_share.password_reset_digest
  end

  test "Shall send password request email on password reset request for existing account" do
    assert_difference 'MessageMailer.deliveries.count' do
      post :create_password_reset, password_reset: { email: 'foo@bar.org' }
    end
  end

  test "Shall do nothing if no account was found to reset password for" do
    assert_no_difference 'MessageMailer.deliveries.count' do
      post :create_password_reset, password_reset: { email: 'somewrongaddress@bar.org' }
      assert_equal 'Zu dieser Email-Adresse wurde kein passender Account gefunden!', flash[:danger]
    end
  end

  test "Shall allow password reset for valid token" do
    @activated_share.create_digest_for(attribute: 'password_reset')
    @activated_share.save

    get :reset_password, id: @activated_share.id, token: @activated_share.password_reset_token
    assert_response :success
  end

  test "Shall alert and redirect to root url if link is invalid" do
    @activated_share.create_digest_for(attribute: 'password_reset')
    @activated_share.save

    get :reset_password, id: @activated_share.id, token: 'Some invalid token'
    assert_equal 'Link zum Passwort zurücksetzen ist ungültig!', flash[:danger]
    assert_redirected_to root_url
  end

  test "Shall not accept tokens older than 24hrs as valid" do
    @activated_share.create_digest_for(attribute: 'password_reset')
    @activated_share.password_reset_timestamp = Time.now - 25.hours
    @activated_share.save

    get :reset_password, id: @activated_share.id, token: @activated_share.password_reset_token
    assert_equal 'Link zum Passwort zurücksetzen ist ungültig!', flash[:danger]
    assert_redirected_to root_url
  end
end
