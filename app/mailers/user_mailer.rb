class UserMailer < ActionMailer::Base
  default Settings.deliver_settings.to_hash

  layout 'mail'

  def activation_needed_email user
    @user = user
    mail(:to => user.email, :subject => t('email.subject.welcome', site: Settings.application.title))
  end
  
  def another_activation_email user
    @user = user
    mail(:to => user.email, :subject => t('email.subject.confirmation'))
  end
  
  def activation_success_email user
    # в реализации дополнение user_activation этот метод необходим, закоментирован,
    # т.к. решили что это письмо будет лишним
    #@user = user
    #@url  = Settings.default_url_options.url + "/login"
    #mail(:to => user.email, :subject => t('email.subject.confirmed'))
  end

  def reset_password_email(user)
    @user = user
    mail(:to => user.email,
         :subject => t('email.subject.password_reset', site: Settings.application.title))
  end
end
