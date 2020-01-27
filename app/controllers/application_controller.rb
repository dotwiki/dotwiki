class ApplicationController < ActionController::Base
  include Banken
  before_action :require_login
  before_action :set_locale
  rescue_from Banken::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized(exception)
    # loyalty_name = exception.loyalty.class.to_s.underscore

    # flash[:error] = t "#{loyalty_name}.#{exception.query}", scope: "banken", default: :default
    flash[:alert] = "エラーが発生しました"
    redirect_to(request.referrer || root_path)
  end
end