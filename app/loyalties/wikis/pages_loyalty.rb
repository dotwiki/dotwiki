class Wikis::PagesLoyalty < ApplicationLoyalty
  def user_level
    record.wiki_maintainers.find_by(user_id: user.id)&.level || 0
  end

  def new?
    user_level >= record.can_page_create_level
  end

  def create?
    new?
  end

  def edit?
    user_level >= record.can_page_edit_level
  end

  def update?
    new?
  end
end
