class Wikis::RequestsController < ApplicationController
  include OnlyMaintainers
  helper_method :current_user_is_maintainer?

  before_action :set_wiki
  before_action :set_page
  before_action :set_request, only: [:show, :edit, :update]

  def index
    @requests = @wiki.pages.find(params[:wiki_page_id]).requests
  end

  def show
    @latest_content = @page.latest_history.content
    @merged_content = merge_content(@latest_content, @request.diff)

    gon.latest_content = @latest_content
    gon.merged_content = @merged_content
  end

  def new
    @request = Request.new(
      content: @page.latest_history.content
    )
  end

  def create
    diff = Diff::LCS.sdiff(@page.latest_history.content.lines, request_params[:content].lines)

    request = Request.new(
      wiki_id: params[:wiki_id],
      page_id: params[:wiki_page_id],
      user_id: current_user.id,
      content: request_params[:content],
      comment: request_params[:comment],
      diff: diff
    )
    
    if request.save
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

  def quick_merge
    request = @page.requests.find(params[:request_id])
    @latest_content = @page.latest_history.content
    @merged_content = merge_content(@latest_content, request.diff)
    if @page.histories.create(user_id: request.user.id, content: @merged_content, comment: request.comment)
      redirect_to wiki_page_path(@wiki, @page), notice: 'マージしました'
      # requestにis_activeを追加
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

  def adjust_merge
    request = @page.requests.find(params[:request_id])
    if @page.histories.create(user_id: request.user.id, content: params[:content], comment: request.comment)
      redirect_to wiki_page_path(@wiki, @page), notice: 'マージしました'
      # requestにis_activeを追加
      # TODO Notificationクラスを追加して通知する
    else
      redirect_to wiki_page_requests_path(@wiki, @page), notice: 'マージに失敗しました'
    end
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

    def set_request
      @request = @page.requests.find(params[:id])
    end

    def request_params
      params.require(:request).permit(:wiki_id, :wiki_page_id, :content, :comment)
    end

    def merge_content(txt, diff)
      line_shift = 0
      result = txt.dup
      diff.each do |df|
        case df["action"]
        when "!"
          unless result.gsub!(/#{df["old_element"]}/, df["new_element"])
            result = result.lines.insert(df["new_position"] + line_shift, "<!-- 変更したかった内容 -->").join
            result = result.lines.insert(df["new_position"] + line_shift, df["new_element"]).join
            line_shift += 2
          end
        when "-"
          if result.gsub!(/#{df["new_element"]}/, '')
            line_shift -= 1
          else
            result = result.lines.insert(df["new_position"] + line_shift, "<!-- 変更したかった内容 -->").join
            result = result.lines.insert(df["new_position"] + line_shift, "<!-- #{df["new_element"]}の削除 -->").join
            line_shift += 2
          end
        when "+"
          result = result.lines.insert(df["new_position"] + line_shift, df["new_element"]).join
          line_shift += 1
        end
      end
      result
    end

    def check_simple_merge(txt)
      
    end
end
