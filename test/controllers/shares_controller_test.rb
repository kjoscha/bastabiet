require "test_helper"

class SharesControllerTest < ActionController::TestCase
  def setup
    @station = Station.create(name: "test_station")
    @group = Group.create(station_id: @station.id, name: "test_group")
  end

  test "Can create share" do
    assert_difference 'Share.count' do
      post :create, share: { name: "test_share", 
                             members: "some test persons in this share",
                             payment: 1,
                             land_help_days: 3,
                             station_help_days: 3,
                             workgroup: 'test_work_group',
                             no_help: false,
                             skills: 'test_skills',
                             size: 2, 
                             password: "secret",
                             password_confirmation: "secret",
                             email: "foo@bar.org",
                             agreed: true,
                             group_id: @group.id }
    end
  end

  test "Does send activation mail on share create" do
    assert_difference 'Share.count' do
      post :create, share: { name: "test_share", 
                             members: "some test persons in this share",
                             payment: 1,
                             land_help_days: 3,
                             station_help_days: 3,
                             workgroup: 'test_work_group',
                             no_help: false,
                             skills: 'test_skills',
                             size: 2, 
                             password: "secret",
                             password_confirmation: "secret",
                             email: "foo@bar.org",
                             agreed: true,
                             group_id: @group.id }
    end
  end
end
