require 'test_helper'

class ActivationsControllerTest < ActionController::TestCase
  def setup
    @station = Station.create(name: "test_station")
    @group = Group.create(station_id: @station.id, name: "test_group")
    @share = add_valid_user(false)
  end

  test "Share becomes activated if token is valid" do
    get :activate_share, token: @share.activation_token, id: @share.id
    assert @share.reload.activated
    assert_equal "Der Anteil wurde erfolgreich aktiviert!", flash[:success]
    assert_redirected_to share_path(@share.id)
  end

  test "Raise error if token is invalid" do
    get :activate_share, token: "some_wrong_token", id: @share.id
    assert_not @share.reload.activated
    assert_equal "Aktivierungs-Link ungültig!", flash[:danger]
    assert_redirected_to root_url
  end

  test "Raise error if id is invalid" do
    get :activate_share, token: @share.activation_token, id: 9999 
    assert_not @share.reload.activated
    assert_equal "Aktivierungs-Link ungültig!", flash[:danger]
    assert_redirected_to root_url
  end
end
