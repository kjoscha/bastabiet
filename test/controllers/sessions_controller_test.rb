require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @group = groups(:Bouffe)
  end

  def user_activated?(activated)
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
                          activated: activated)
  end

  test 'activated shares can log in' do 
    user_activated?(true)
    post :create, session: { email: @share.email, password: @share.password }
    assert_redirected_to share_path(@share.id)
    assert_equal @share.id, session[:share_id]
  end

  test 'non-activated shares cannot log in' do 
    user_activated?(false)
    post :create, session: { email: @share.email, password: @share.password }
    assert_template :new
    assert_not session[:share_id]
  end
end
