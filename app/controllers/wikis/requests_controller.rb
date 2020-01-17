class Wikis::RequestsController < ApplicationController
  include OnlyMaintainers
  helper_method :current_user_is_maintainer?

  before_action :set_wiki
  before_action :set_page

  def index
    @requests = @wiki.pages.find(params[:wiki_page_id]).requests
  end

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

  def review
gon.old_text = "
登場人物の名前は創作のほか、「奇抜に見えるが実在する」姓名が多用されている。
敵方である「鬼」については、身体破壊や人喰いなどのハードな描写が多いが、
その一方で不死性をコミカルに描くような側面もある。ほげほげ。
また、主人公の炭治郎をはじめとする人間たちもシリアスとコメディの両側面が描かれている。

舞台は大正時代の日本。
開国と文明開化から半世紀近くが経っていて、和の中に洋が混在する。
都市部は発展しているが、地方部は前時代が色濃く残る。ふーばー。
また廃刀令や科学文明の大正現代に夜に潜む鬼などいるわけがないなどの理由により、
政府不認可なので、鬼殺隊は表立った行動に制限がある。

浅草、吉原など現実の大正時代の土地も描かれる。
"
gon.new_text = "
登場人物の名前は創作のほか、「奇抜に見えるが実在する」姓名が多用されている。
敵方である「鬼」については、身体破壊や人喰いなどのハードな描写が多いが、
その一方で不死性をコミカルに描くような側面もある。
また、主人公の炭治郎をはじめとする人間たちもシリアスとコメディの両側面が描かれている。

舞台は大正時代の日本。
都市部は発展しているが、地方部は前時代が色濃く残る。
また廃刀令や科学文明の大正現代に夜に潜む鬼などいるわけがないなどの理由により、
政府不認可なので、鬼殺隊は表立った行動に制限がある。

浅草、吉原など現実の大正時代の土地も描かれる。てすてす。
"

  end

  def merge
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
