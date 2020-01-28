class Wikis::MaintainersController < ApplicationController
  before_action :set_wiki

  def index
    authorize! @wiki
    @maintainers = @wiki.maintainers
    @watchers = @wiki.watchers.reject{|v| @maintainers.include?(v)}
  end

  def update
    authorize! @wiki
    @maintainer = @wiki.wiki_maintainers.new(user_id: params[:id])

    respond_to do |format|
      if @maintainer.save
        format.html { redirect_to maintainers_path(@wiki), notice: t('.notice') }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    authorize! @wiki
    @wiki.wiki_maintainers.find_by(user_id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to maintainers_path(@wiki), notice: t('.notice') }
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
