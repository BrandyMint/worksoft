class UserMailer < ActionMailer::Base
  default from: Settings.noreply_email

  def activation_needed_email user
    confirm_email_content user
    mail(:to => user.email, :subject => t('email.subject.welcome', site: Settings.application.title))
  end
  
  def another_activation_email user
    confirm_email_content user
    mail(:to => user.email, :subject => t('email.subject.confirmation'))
  end
  
  def activation_success_email user
    #@user = user
    #@url  = Settings.default_url_options.url + "/login"
    #mail(:to => user.email, :subject => t('email.subject.confirmed'))
  end

private
  def confirm_email_content user
    @user = user
    @url  = "http//#{Settings.default_url_options.host}/activate/#{user.activation_token}"
  end
end
