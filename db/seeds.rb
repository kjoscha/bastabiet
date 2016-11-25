Group.add_existent

Group.all.each do |group|
  rand(1..4).times do
      group.shares.build(
        name:              Faker::Lorem.word,
        members:           Faker::Lorem.words(rand(8)).join(', '),
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
        station_help_days: (1..10).to_a.sample,
        workgroup:         Faker::Lorem.word,
        skills:            Faker::Lorem.words(rand(3)).join(', '),
        no_help:           [true, false].sample,
    ).save
  end
end
