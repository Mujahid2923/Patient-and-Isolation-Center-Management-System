class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)

    if @invitation.save
      UserMailer.invite_email(current_user, @invitation).deliver

      flash[:notice] = 'Invitations Send Successfully'
      redirect_to root_path
    else
      flash[:danger] = 'Failed to send Invitations'
      render('new')
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
