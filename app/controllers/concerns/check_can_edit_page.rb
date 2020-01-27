module CheckCanEditPage
  extend ActiveSupport::Concern

  # included do
    # ここにcallback等
  # end

  # メソッド
  def check_can_edit_page
    result = false
    if current_user.is_maintainer?(@wiki.id)
      result = true
    elsif @wiki.can_edit? && @wiki.contributors.find_by(id: current_user.id)
      result = true
    end
    result
  end

  private

  # privateメソッド

end