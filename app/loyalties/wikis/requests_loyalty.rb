class Wikis::RequestsLoyalty < ApplicationLoyalty
  def user_level
    record.wiki_maintainers.find_by(user_id: user.id)&.level || 0
  end

  def new?
    user_level >= record.can_page_request_level
  end

  def create?
    new?
  end

  def edit?
    new? || user = record.user
  end

  def update?
    new? || user = record.user
  end

  def destroy?
    new? || user = record.user
  end

  def merge?
    user_level >= record.can_page_edit_level
  end

  def adjust?
    merge?
  end

  def reject?
    merge?
  end
end
