class MessageMailer < ApplicationMailer
  default from: 'basta@lupus.uberspace.de'

  RECEIVERS = %w[
    willkommen@csa-basta.org
    basta@posteo.de
    basta@lupus.uberspace.de
    jo5cha@web.de
  ].freeze

  def send_password_reset_link(share)
    @share = share
    @password_reset_link = reset_password_url id: @share.id, token: @share.password_reset_token
    mail(to: share.email, subject: 'Password zurücksetzen für Bastabiet')
  end

  def activation_link(share)
    @share = share
    @activation_link = activate_share_url id: @share.id, token: @share.activation_token
    mail(to: share.email, subject: 'Bastabiet-Account aktivieren')
  end

  def remind_registering(share)
    @share = share
    mail(to: share.email, subject: 'Bitte auf Bastabiet registrieren!')
  end

  def new_bidding(share)
    @share = share
    mail(to: share.email, subject: 'Neue Bietrunde offen!')
  end

  def bidding_over(share, email)
    attachments['Vereinbarung.pdf'] = File.read(Rails.root + 'public/basta_vereinbarung_2017.pdf')
    @share = share
    mail(to: email, subject: 'Die Bietrunde ist abgeschlossen!')
  end

  def admin_notification_change(share, changes)
    unless changes.empty?
      @share = share
      @changes = changes
      RECEIVERS.each do |email|
        mail(to: email, subject: 'Ernteanteil geändert')
      end
    end
  end

  def admin_notification_creation(share)
    @share = share
    RECEIVERS.each do |email|
      mail(to: email, subject: 'Neuer Ernteanteil')
    end
  end
end
