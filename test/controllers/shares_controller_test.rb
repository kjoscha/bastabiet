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
        group_id: @group.id
      }
    end
  end

  test 'guest cannot destroy shares' do 
    assert_no_difference('Share.count') do
      delete :destroy, id: @share.id
    end
  end

  test 'guest cannot update shares' do 
    patch :update, id: @share, share: { payment: 3 }
    assert_not_equal 3, @share.payment
  end

  test 'admin can destroy shares' do
    session[:admin] = true
    assert_difference('Share.count', -1) do
      delete :destroy, id: @share.id
    end
  end

  test 'logged in share can destroy itself' do
    session[:share_id] = @share.id
    assert_difference('Share.count', -1) do
      delete :destroy, id: @share.id
    end
  end
end
