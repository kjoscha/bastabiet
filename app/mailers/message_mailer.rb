class MessageMailer < ApplicationMailer
  default from: 'no-reply@lpkb.menkent.uberspace.de'

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

  def generic_message(share, message)
    @share = share
    @message = message
    mail(to: share.email, subject: @message.subject) 
  end
end
