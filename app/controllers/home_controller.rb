class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    @recent_created_wikis = Wiki.order(id: :desc).limit(10)
    @waching_wikis = current_user.watches.map{|v| v.wiki} rescue []
    @news = Notification.where(wiki_id: current_user.watches.pluck(:id)).order(updated_at: :desc).limit(10) rescue []
  end

  def thanks
  end
end 
