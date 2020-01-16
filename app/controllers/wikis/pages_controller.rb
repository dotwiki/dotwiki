class Wikis::PagesController < ApplicationController
  include OnlyMaintainers
  helper_method :current_user_is_maintainer?

  before_action :only_maintainers, except: [:index, :show]
  before_action :set_wiki
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show]


  # GET /pages
  # GET /pages.json
  def index
    @pages = @wiki.pages.all
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = @wiki.pages.new
    @page.histories.build
  end

  # GET /pages/1/edit
  def edit
    @page.histories.build(
      @page.latest_history.attributes.except('id', 'created_at', 'updated_at')
    )
  end

  # POST /pages
  # POST /pages.json
  def create
    params["page"]["histories_attributes"]["0"]["user_id"] = current_user.id
    @page = @wiki.pages.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to wiki_page_path(@wiki, @page), notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    params["page"]["histories_attributes"]["0"]["user_id"] = current_user.id

    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to wiki_page_path(@wiki, @page), notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  # def destroy
  #   @page.destroy
  #   respond_to do |format|
  #     format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_wiki
      @wiki = Wiki.find(params[:wiki_id])
      gon.wiki_id = @wiki.id
      gon.wathing_wiki = current_user.watches.find_by(wiki_id: @wiki.id) if current_user
    end
    
    def set_page
      @page = @wiki.pages.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:wiki_id, :title, histories_attributes: [:content, :user_id])
    end
end
