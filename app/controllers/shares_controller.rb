class SharesController < ApplicationController
  before_action :admin_or_current_share, only: [:show, :edit, :update, :destroy]
  before_action :is_activated?, only: [:update]
  before_action :validate_email_subject_and_text_present, only: [:send_mail]

  def new
    @groups = Group.all
    @group_selection = @groups.map{ |g| [g.name, g.id] }
    @share = Share.new
  end

  def create
    @groups = Group.all
    if share_params[:group_id] == ''
      flash[:danger] = 'Gruppe wählen!'
      redirect_to :register
    else
      @group = Group.find(share_params[:group_id])
      @group_selection = @groups.map{ |g| [g.name, g.id] }
      @share = @group.shares.build(share_params)
      if @share.save
        if admin? && @share.update(activated: true)
          MessageMailer.admin_created_share(@share).deliver_now
          flash[:success] = "Der Account wurde erfolgreich angelegt. Es wurde eine Email an die angegebene Mailadresse geschickt."
          redirect_to root_url
        else
          MessageMailer.activation_link(@share).deliver_now
          flash[:success] = "Der Account wurde erfolgreich angelegt, muss aber noch aktiviert werden. Folge dazu einfach dem Link in der Aktivierungs-Email, die wir dir soeben zugesandt haben!"
          redirect_to root_url
        end
      else
        flash[:danger] = @share.errors.full_messages.to_sentence
        render :new
      end
    end
  end

  def show
    @share = Share.find(params[:id])
  end

  def update
    @share = Share.find(params[:id])
    @share.form_edit
    if @share.update_attributes(share_params) && fill_offers(@share)
      flash[:success] = 'Erfolgreich aktualisiert'
    else
      flash[:danger] = @share.errors.full_messages.to_sentence
    end
    redirect_to :back
  end

  def destroy
    @share = Share.find(params[:id])
    @share.destroy
    redirect_to :back
  end

  def current_shares_home
    if logged_in?
      redirect_to share_path(current_share)
    else
      redirect_to login_path
    end
  end

  def send_mail
    share_ids = params[:ids_for_custom_mail]

    if share_ids&.any?
      share_emails = Share.where(id: share_ids).pluck(:email)
      member_emails = Member.where(share_id: share_ids).pluck(:email)
      emails = (share_emails + member_emails + [params[:email_from]]).uniq
      MessageMailer.custom_mail(
        emails: emails,
        from: params[:email_from],
        subject: params[:email_subject],
        text: params[:email_text]
      ).deliver_now
      flash[:success] = 'Email(s) erfolgreich gesendet!'
    else
      flash[:danger] = 'Keine Empfänger_innen ausgewählt!'
    end
    redirect_to :back
  end

  private

  def validate_email_subject_and_text_present
    return true if params[:email_subject].present? && params[:email_text].present?
    flash[:danger] = 'Betreff und Text dürfen nicht leer sein!'
    redirect_to :back
  end

  def fill_offers(share)
    all_offers = share.all_offers
    @share.update_attributes!(
      offer_minimum:  all_offers[0] || all_offers[1] || all_offers[2],
      offer_medium:   all_offers[1] || all_offers[0] || all_offers[2],
      offer_maximum:  all_offers[2] || all_offers[1] || all_offers[0],
    )
  end

  def share_params
    params.require(:share).permit(:name, :size, :group_id, :email, :telephone, :offer_minimum, :offer_medium, :offer_maximum, :password, :password_confirmation, :feedback, :land_help_days, :no_help, :skills, :payment, :agreed, workgroup_ids: [])
  end

  def is_activated?
    unless Share.find(params[:id]).activated
      flash[:danger] = "Dieser Anteil wurde noch nicht aktiviert!"
      redirect_to root_url
    end
  end
end
