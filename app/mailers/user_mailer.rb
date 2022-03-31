class UserMailer < ApplicationMailer
  def invite_email(user, invitation)
    @invitation = invitation
    @user = user
    @url  = new_user_registration_url(email: @invitation.email)
    mail(
      to: @invitation.email,
      subject: 'Please follow the bellow instruction to sign up',
      from: user.email
    )
  end
end
