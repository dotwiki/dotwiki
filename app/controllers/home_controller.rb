class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    if current_user
      @waching_wikis = current_user&.watches.map { |v| v.wiki }
      @news = Notification.where(wiki_id: current_user.watches.pluck(:wiki_id))
                          .order(updated_at: :desc)
                          .limit(10)
    end
  end

  def thanks
  end
end
