class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_locale

  private
  def not_authenticated
    redirect_to login_path, alert: t('user_sessions.please_login_first')
  end
  
  def require_login
    unless current_user
      redirect_to login_url
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end