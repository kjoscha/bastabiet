require 'test_helper'

class ShareSessionsControllerTest < ActionController::TestCase

  def setup
    @group = groups(:Bouffe)
  end

  test 'activated shares can log in' do
    add_valid_user(true)
    post :create, session: { email: @share.email, password: @share.password }
    assert_redirected_to share_path(@share.id)
    assert_equal @share.id, session[:share_id]
  end

  test 'non-activated shares cannot log in' do
    add_valid_user(false)
    post :create, session: { email: @share.email, password: @share.password }
    assert_template :new
    assert_not session[:share_id]
  end
end
