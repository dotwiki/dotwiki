class Wikis::RequestsController < ApplicationController
  include OnlyMaintainers
  helper_method :current_user_is_maintainer

  before_action :set_wiki
  before_action :set_page
  before_action :set_request, only: [:show, :edit, :update]
  before_action :check_same_user, only: [:edit, :update]
  before_action :only_maintainers, only: [:quick_merge, :adjust, :adjust_merge, :reject]
  skip_before_action :require_login, only: [:index, :show]

  def index
    @requests = @wiki.pages.find(params[:wiki_page_id]).requests
  end

  def show
    @latest_content = @page.latest_history.content
    @merged_content = merge_content(@latest_content.dup, @request.diff)
    @latest2 = @page.histories

    binding.pry

    gon.latest_content = @latest_content
    gon.merged_content = @request.content
  end

  def new
    @request = Request.new(
      content: @page.latest_history.content
    )
  end

  def create
    diff = Diff::LCS.sdiff(@page.latest_history.content.lines, request_params[:content].lines)

    @request = Request.new(
      wiki_id: params[:wiki_id],
      page_id: params[:wiki_page_id],
      user_id: current_user.id,
      content: request_params[:content],
      comment: request_params[:comment],
      diff: diff
    )
    
    if @request.save
      redirect_to wiki_page_path(@wiki, @page), notice: 'リクOK'
    else
      render :new
    end
  end

  def edit
  end

  def update
    page = Page.find(params[:wiki_page_id])
    diff = Diff::LCS.sdiff(page.latest_history.content.lines, request_params[:content].lines)

    if @request.update(content: request_params[:content], diff: diff)
      redirect_to wiki_page_path(@wiki, @page), notice: 'リクOK'
    else
      render :edit
    end
  end

  def merge
    request = @page.requests.find(params[:request_id])
    if @page.histories.create(user_id: request.user.id, content: params[:content], comment: request.comment)
      request.destroy
      redirect_to wiki_page_path(@wiki, @page), notice: 'マージしました'
      # TODO Notificationクラスを追加して通知する
    else
      redirect_to wiki_page_requests_path(@wiki, @page), notice: 'マージに失敗しました'
    end
  end

  def adjust
    @request = @page.requests.find(params[:request_id])
    @latest_content = @page.latest_history.content
    @merged_content = merge_content(@latest_content, @request.diff)
  end

  def reject
    request = @page.requests.find(params[:request_id])
    request.destroy
    redirect_to wiki_page_requests_path(@wiki, @page), notice: t('.notice')
  end

  private
    def request_params
      params.require(:request).permit(:wiki_id, :wiki_page_id, :content, :comment)
    end

    def set_wiki
      @wiki = Wiki.find(params[:wiki_id])
      gon.wiki_id = @wiki.id
      gon.wathing_wiki = current_user.watches.find_by(wiki_id: @wiki.id) if current_user
    end

    def set_page
      @page = @wiki.pages.find(params[:wiki_page_id])
    end

    def set_request
      @request = @page.requests.find(params[:id])
    end

    def check_same_user
      unless current_user == @request.user
        redirect_to wiki_page_path(@wiki, @page)
      end
    end

    def merge_content(latest_content, diff)
      result
    end
end
