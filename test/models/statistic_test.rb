require 'test_helper'

class StatisticTest < ActiveSupport::TestCase
  test 'calculates correct sum' do
    create_shares
    assert_equal 30, Statistic.new('offer_minimum').monthly_sum
    assert_equal 60, Statistic.new('offer_medium').monthly_sum
    assert_equal 110, Statistic.new('offer_maximum').monthly_sum
  end

  test 'calculates correct average' do
    create_shares
    assert_equal 25, Statistic.new('offer_minimum').monthly_average
    assert_equal 50, Statistic.new('offer_medium').monthly_average
    assert_equal 95, Statistic.new('offer_maximum').monthly_average
  end

  test 'calculates correct needed average' do
    create_shares
    assert_equal 87.98, Statistic.new('offer_minimum').needed_monthly_average
    assert_equal 87.98, Statistic.new('offer_medium').needed_monthly_average
    assert_equal 87.98, Statistic.new('offer_maximum').needed_monthly_average
  end

  test 'calculates correct total size of shares with offers' do
    create_shares
    # compare with count of registered shares
    assert_equal 3.5, Share.size_altogether.round(1)

    assert_equal 1.5, Statistic.new('offer_minimum').total_share_size_with_offers
    assert_equal 1.5, Statistic.new('offer_medium').total_share_size_with_offers
    assert_equal 1.5, Statistic.new('offer_maximum').total_share_size_with_offers
  end

  def create_shares
    @group = groups :Bouffe
    Share.create(group_id: @group.id,
                  name: "test share", 
                  payment: 1,
                  land_help_days: 3,
                  no_help: false,
                  skills: 'test_skills',
                  size: 0.5,
                  password: "secret",
                  password_confirmation: "secret",
                  email: "foo@bar.org",
                  agreed: true,
                  offer_minimum: 20,
                  offer_medium: 40,
                  offer_maximum: 80,
                )
    Share.create( group_id: @group.id,
                  name: "test share 2", 
                  payment: 1,
                  land_help_days: 3,
                  no_help: false,
                  skills: 'test_skills',
                  size: 1,
                  password: "secret",
                  password_confirmation: "secret",
                  email: "foo2@bar.org",
                  agreed: true,
                  offer_minimum: 10,
                  offer_medium: 20,
                  offer_maximum: 30,
                )
    Share.create( group_id: @group.id,
                  name: "test share 3", 
                  payment: 1,
                  land_help_days: 3,
                  no_help: false,
                  skills: 'test_skills',
                  size: 1,
                  password: "secret",
                  password_confirmation: "secret",
                  email: "foo3@bar.org",
                  agreed: true,
                )
  end
end
