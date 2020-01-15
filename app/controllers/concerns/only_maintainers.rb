module OnlyMaintainers
  extend ActiveSupport::Concern

  # included do
    # ここにcallback等
  # end

  # if user_is_maintainer
  def current_user_is_maintainer?
    Wiki.find(params[:wiki_id]).maintainers.find_by(id: current_user.id)
  end
  
  def only_maintainers
    unless current_user_is_maintainer?
      redirect_to wiki_path(params[:wiki_id]), alert: t('wikis.check_maintainer.alert')
    end
  end

  private

  # privateメソッド

end