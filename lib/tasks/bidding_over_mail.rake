namespace :bidding_over_mail do

  desc 'Send a mail to all shares'
  task send: :environment do
    Share.all.each do |share|
      MessageMailer.bidding_over(share, share.email).deliver_now
      share.members.each do |member|
        MessageMailer.bidding_over(share, member.email).deliver_now
      end
    end
  end

  desc 'Send a test mail'
  task test: :environment do
    share = Share.find_by(email: 'matteo.toller@gmail.com')
    MessageMailer.bidding_over(share, 'jo5cha@web.de').deliver_now
    MessageMailer.bidding_over(share, share.email).deliver_now
  end
end
