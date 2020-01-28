class Wikis::NavsLoyalty < ApplicationLoyalty
  def user_level
    record.wiki_maintainers.find_by(user_id: user.id)&.level || 0
  end

  def edit?
    user_level >= record.can_navs_edit_level
  end

  def update?
    new?
  end
end
