class Wikis::AttachmentsController < ApplicationController
  before_action :set_wiki

  def index
    gon.wiki_id = @wiki.id
  end

  def all
    @attachments = @wiki.attachments.order(id: :desc)
    render "all"
  end

  def create
    attachment = @wiki.attachments.new
    attachment.file = params[:file]
    attachment.store_file!
    if attachment.save
      render body: nil, status: 200
    else
      render body: nil, status: 500
    end
  end

  def update
    attachment = Attachment.find(params[:id])
    attachment.shortcode = params[:shortcode]
    if attachment.save
      render body: nil, status: 200
    else
      # render body: nil, status: 204 # TODO できればここで重複だけは教えてあげたい
      render body: nil, status: 500
    end
  end

  def destroy
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
