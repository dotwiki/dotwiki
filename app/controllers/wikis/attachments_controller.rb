class Wikis::AttachmentsController < ApplicationController
  before_action :set_wiki

  def index
    @attachments = @wiki.attachments
  end

  def new
    @attachment = @wiki.attachment.new
  end

  def create
  end

  def edit
  end

  def update
    attachment = Attachment.find(params[:id])
    attachment.shortcode = params[:shortcode]
    if attachment.save
      respond_to do |format|
        format.js { flash[:notice] = "ショートコードを変更しました" } 
      end
    else
      respond_to do |format|
        format.js { flash[:alert] = "エラーが発生しました" } 
      end
    end
  end

  def destroy
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
