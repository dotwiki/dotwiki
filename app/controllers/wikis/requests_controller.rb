class Wikis::RequestsController < ApplicationController
  include OnlyMaintainers
  helper_method :current_user_is_maintainer?

  before_action :set_wiki
  before_action :set_page

  def new
    @page = Page.find(params[:wiki_page_id])
    @request = Request.new(
      content: @page.latest_history.content
    )
  end

  def edit
  end

  def show
  end

  def create
    page = Page.find(params[:wiki_page_id])
    diff = Diff::LCS.sdiff(page.latest_history.content.lines, request_params[:content].lines)

    request = Request.new(
      wiki_id: params[:wiki_id],
      page_id: params[:wiki_page_id],
      user_id: current_user.id,
      content: request_params[:content],
      comment: request_params[:comment],
      diff: diff
    )
    
    if request.save
      redirect_to wiki_page_path(params[:wiki_id], params[:wiki_page_id]), notice: 'リクOK'
    else
      render :new
    end
  end

  def update
  end

  def merge
  end

  def reject
  end

  private
    def set_wiki
      @wiki = Wiki.find(params[:wiki_id])
      gon.wiki_id = @wiki.id
      gon.wathing_wiki = current_user.watches.find_by(wiki_id: @wiki.id) if current_user
    end

    def set_page
      @page = @wiki.pages.find(params[:wiki_page_id])
    end

    def request_params
      params.require(:request).permit(:wiki_id, :wiki_page_id, :content, :comment)
    end
end
