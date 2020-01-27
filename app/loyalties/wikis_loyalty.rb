class WikisLoyalty < ApplicationLoyalty
  def edit?
    record.maintainers.find_by(id: user.id)
  end
end
