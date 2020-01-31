namespace :bidding_over_mail do

  desc 'Send a mail to all shares'
  task send: :environment do
    Share.all.each do |share|
      p "----- #{share.group.name} -----"
      p share.email
      MessageMailer.bidding_over_2020_01(share, share.email).deliver_now
    end
  end

  desc 'Send a test mail'
  task test: :environment do
    share = Share.first
    MessageMailer.bidding_over_2020_01(share, 'jo5cha@web.de').deliver_now
  end
end
