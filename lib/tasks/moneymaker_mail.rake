namespace :moneymaker_mail do

  desc 'Send a mail to all super moneymakers'
  task send: :environment do
    Share.all.each do |share|
      p "----- #{share.name} -----"
      p share.email
      MessageMailer.moneymaker(share, share.email).deliver_now
      share.members.each do |member|
        p member.email
        MessageMailer.bidding_over(share, member.email).deliver_now
      end
    end
  end

  desc 'Send a test mail'
  task test: :environment do
    share = Share.first
    MessageMailer.moneymaker(share, 'jo5cha@web.de').deliver_now
  end
end
