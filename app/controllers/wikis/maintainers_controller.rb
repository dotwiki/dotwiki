class Wikis::MaintainersController < ApplicationController
  include OnlyMaintainers
  before_action :only_maintainers

  def index
    @wiki = Wiki.find(params[:wiki_id])
    @maintainers = @wiki.maintainers
    @watchers = @wiki.watchers.reject{|v| @maintainers.include?(v)}
  end

  def update
    @maintainer = Wiki.find(params[:wiki_id]).wiki_maintainers.new(user_id: params[:id])

    respond_to do |format|
      if @maintainer.save
        format.html { redirect_to maintainers_path(params[:wiki_id]), notice: t('.notice') }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    WikiMaintainer.find_by(user_id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to maintainers_path(params[:wiki_id]), notice: t('.notice') }
    end
  end
end
