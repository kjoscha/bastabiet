require "test_helper"

class SharesControllerTest < ActionController::TestCase

  def setup
    @station = stations(:Ida)
    @group = groups(:Bouffe)
    @share = shares(:Joscha)
    request.env["HTTP_REFERER"] = 'where_i_came_from'
  end

  def http_login
    user = 'admin'
    pw = 'secret'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  test 'Can create share' do
    assert_difference 'Share.count' do
      post :create, share: {
        name: "Test user",
        land_help_days: 3,
        no_help: false,
        skills: 'test_skills',
        size: 1,
        password: "secret",
        password_confirmation: "secret",
        email: "foo@bar.org",
        telephone: "0307187623",
        agreed: true,
        group_id: @group.id
      }
    end

    assert_equal "0307187623", Share.find_by(email: "foo@bar.org").telephone
  end

  test 'landing page depending on login state' do
    get :current_shares_home
    assert_redirected_to login_path
    session[:share_id] = @share.id
    get :current_shares_home
    assert_redirected_to share_path(@share.id)
  end

  test 'guest cannot see shares' do
    get :show, id: @share.id
    assert_redirected_to root_path
  end

  test 'guest cannot destroy shares' do
    assert_no_difference('Share.count') do
      delete :destroy, id: @share.id
    end
  end

  test 'guest cannot update shares' do
    patch :update, id: @share.id, share: { offer_minimum: 7634 }
    assert_not_equal 7634, @share.offer_minimum
  end

  test 'admin can destroy shares' do
    session[:admin] = true
    assert_difference('Share.count', -1) do
      delete :destroy, id: @share.id
    end
  end

  test 'admin can update shares' do
    skip 'not working?!'
    session[:admin] = true
    patch :update, id: @share.id, share: { offer_minimum: 1564 }
    @share.reload
    assert_equal 1564, @share.offer_minimum
  end

  test 'logged in share can destroy itself' do
    session[:share_id] = @share.id
    assert_difference('Share.count', -1) do
      delete :destroy, id: @share.id
    end
  end

  test 'logged in share cannot destroy other shares' do
    @other_share = shares(:Hanswurst)
    session[:share_id] = @share.id
    assert_difference('Share.count', 0) do
      delete :destroy, id: @other_share.id
    end
  end

  test 'logged in share can update itself' do
    skip 'to do'
    session[:share_id] = @share.id
    patch :update, id: @share.id, share: { offer_minimum: 12}
    @share.reload
    assert_equal 12, @share.offer_minimum
  end
end
