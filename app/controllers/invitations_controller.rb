class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)

    if @invitation.save
      UserMailer.invite_email(current_user, @invitation).deliver

      flash[:notice] = I18n.t('notice.create.success', resource: Invitation.model_name.human)
      redirect_to root_path
    else
      flash[:danger] = I18n.t('notice.create.failed', resource: Invitation.model_name.human)
      render('new')
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
