Group.add_existant
Workgroup.add_existant

Group.find(1).shares.build(
  name:              Faker::Name.name,
  size:              [1].sample,
  email:             'test@test.com',
  password:               'secret',
  password_confirmation:  'secret',
  offer_minimum:     (60..80).to_a.sample,
  offer_medium:      (80..100).to_a.sample,
  offer_maximum:     (100..120).to_a.sample,
  agreed:            true,
  payment:           [1, 3, 12].sample,
  land_help_days:    (1..10).to_a.sample,
  skills:            Faker::Lorem.words(rand(3)).join(', '),
  no_help:           [true, false].sample,
  activated:         true
).save

Group.all.each do |group|
  rand(1..4).times do
      group.shares.build(
        name:              Faker::Name.name,
        size:              [0.5, 1, 1.5, 2].sample,
        email:             Faker::Internet.email,
        password:               'secret',
        password_confirmation:  'secret',
        offer_minimum:     (60..80).to_a.sample,
        offer_medium:      (80..100).to_a.sample,
        offer_maximum:     (100..120).to_a.sample,
        agreed:            true,
        payment:           [1, 3, 12].sample,
        land_help_days:    (1..10).to_a.sample,
        skills:            Faker::Lorem.words(rand(3)).join(', '),
        no_help:           [true, false].sample,
        activated:         [true, false].sample,
    ).save
  end
end

Setting.new(
  needed_sum: 10_000,
  show_statistics: true,
).save
