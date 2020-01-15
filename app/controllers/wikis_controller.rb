class WikisController < ApplicationController
  include OnlyMaintainers
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]
  before_action :only_maintainers, except: [:index, :show, :new, :create]
  skip_before_action :require_login, only: [:index, :show]

  helper_method :current_user_is_maintainer?
  
  # GET /wikis
  # GET /wikis.json
  def index
    @wikis = Wiki.all
  end

  # GET /wikis/1
  # GET /wikis/1.json
  def show
  end

  # GET /wikis/new
  def new
    @wiki = Wiki.new
  end

  def edit
  end

  def upload
    @wiki = Wiki.find(params[:wiki_id])
    attachment = @wiki.attachments.new
    attachment.file = params[:file]
    attachment.store_file!
    attachment.save!
    
    if Rails.env.production?
      cloudinary_url = 'https://res.cloudinary.com/dotwiki/'.freeze
      file_path = cloudinary_url + attachment.file_was
    else
      file_path = attachment.file.url
    end
    render json: { filename: file_path }
  end

  # POST /wikis
  # POST /wikis.json
  def create
    @wiki = Wiki.new(wiki_params)

    respond_to do |format|
      if @wiki.save
        wiki_maintainer = @wiki.wiki_maintainers.new(user: current_user)
        wiki_maintainer.save
        format.html { redirect_to @wiki, notice: t('.notice') }
        format.json { render :show, status: :created, location: @wiki }
      else
        format.html { render :new }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wikis/1
  # PATCH/PUT /wikis/1.json
  def update
    respond_to do |format|
      if @wiki.update(wiki_params)
        format.html { redirect_to @wiki, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @wiki }
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wikis/1
  # DELETE /wikis/1.json
  # def destroy
  #   @wiki.destroy
  #   respond_to do |format|
  #     format.html { redirect_to wikis_url, notice: t('.notice') }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wiki
      @wiki = Wiki.find(params[:wiki_id])
      gon.wiki_id = @wiki.id
      gon.wathing_wiki = current_user.watches.find_by(wiki_id: @wiki.id) if current_user
      gon.current_user = current_user.id if current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wiki_params
      params.require(:wiki).permit(:title, :description, :terms, images: [])
    end
end
