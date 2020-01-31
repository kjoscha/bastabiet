namespace :moneymaker_mail do

  desc 'Send a mail to all super moneymakers'
  task send: :environment do
    Share.where(super_moneymaker: true).each do |share|
      p "----- #{share.name} -----"
      p share.email
      MessageMailer.moneymaker(share, share.share_moneymaker&.email).deliver_now
    end
  end

  desc 'Send a test mail'
  task test: :environment do
    share = Share.first
    MessageMailer.moneymaker(share, 'jo5cha@web.de').deliver_now
  end
end
