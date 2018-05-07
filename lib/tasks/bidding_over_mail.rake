namespace :bidding_over_mail do

  desc 'Send a mail to all shares'
  task send: :environment do
    Share.all.each do |share|
      p "----- #{share.name} -----"
      p share.email
      MessageMailer.bidding_over(share, share.email).deliver_now
      share.members.each do |member|
        p member.email
        MessageMailer.bidding_over(share, member.email).deliver_now
      end
    end
  end

  desc 'Send a test mail'
  task test: :environment do
    share = Share.first
    MessageMailer.bidding_over(share, 'jo5cha@web.de').deliver_now
  end
end
