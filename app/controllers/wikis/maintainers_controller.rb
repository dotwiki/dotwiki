class Wikis::MaintainersController < ApplicationController
  before_action :set_wiki

  def index
    authorize! @wiki
    @maintainers = @wiki.wiki_maintainers
    @watchers = @wiki.watchers.reject{|v| @wiki.maintainers.include?(v)}
  end

  def update
    authorize! @wiki
    maintainer = @wiki.wiki_maintainers.find_by(user_id: params[:id])
    maintainer.level = params[:level].to_i
    maintainer.save
  end

  def create
    authorize! @wiki
    @maintainer = @wiki.wiki_maintainers.new(user_id: params[:user_id])

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
    @wiki.wiki_maintainers.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to maintainers_path(@wiki), notice: t('.notice') }
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
    gon.wiki_id = @wiki.id
    gon.wathing_wiki = current_user.watches.find_by(wiki_id: @wiki.id) if current_user
    gon.current_user = current_user.id if current_user
  end
end
