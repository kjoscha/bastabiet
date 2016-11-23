class MessageMailer < ApplicationMailer
  default from: 'noreply@lpkb.menkent.uberspace.de'

  def password_reset(share)
    @share = share
    @password_reset_link = nil
    mail(to: share.email, subject: 'Password zurücksetzen für Bastabiet') 
  end

  def activation_link(share)
    @share = share
    @activation_link = activate_url @share.activation_token
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
