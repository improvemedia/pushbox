class MarketingMailer < ApplicationMailer
  def marketing_email(letter)
    @content = letter.content

    mail(to: letter.user.email, subject: letter.subject)
  end
end
