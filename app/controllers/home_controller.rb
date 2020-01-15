class HomeController < ApplicationController
  skip_before_action :require_login
  def index
    @wikis = Wiki.all.order(id: :desc)
  end
end
