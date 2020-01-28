class Wikis::MaintainersLoyalty < ApplicationLoyalty
  def user_level
    record.wiki_maintainers.find_by(user_id: user.id)&.level || 0
  end

  def index?
    user_level >= 3
  end

  def update?
    index?
  end

  def create?
    index?
  end

  def destroy?
    index?
  end
end
