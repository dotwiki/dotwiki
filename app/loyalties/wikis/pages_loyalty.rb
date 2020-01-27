class Wikis::PagesLoyalty < ApplicationLoyalty
  def user_level
    record.wiki_maintainers.find_by(user_id: user.id)&.level || 0
  end

  def new?
    user_level >= record.can_edit_before_type_cast
  end

  def show?
  end
end
