class UserMailer < ApplicationMailer
  def invite_email(user, invitation)
    @invitation = invitation
    @user = user
    @url  = new_user_registration_url(facility_id: 1)
    mail(
      to: @invitation.email,
      subject: 'Please follow the bellow instruction to sign up',
      from: user.email
    )
  end
end
