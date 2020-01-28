class Wikis::NavsController < ApplicationController
  before_action :set_wiki

  def edit
    authorize! @wiki
    @wiki = Wiki.includes(:pages).find(params["wiki_id"])
    gon.wiki_id = @wiki.id
    display_pages = []
    rej = []
    @wiki.nav.each do |nv|
      unless nv.is_a?(Array)
        pa_page = @wiki.pages.find(nv["page_id"])
        display_pages << {title: pa_page.title, page_id: pa_page.id}
        rej << pa_page.id
      else
        children = []
        nv.each do |nvc|
          unless nvc.is_a?(Array)
            ch_page = @wiki.pages.find(nvc["page_id"])
            children << {title: ch_page.title, page_id: ch_page.id}
            rej << ch_page.id
          else
            gchildren = []
            nvc.each do |nvcc|
              gc_page = @wiki.pages.find(nvcc["page_id"])
              gchildren << {title: gc_page.title, page_id: gc_page.id}
              rej << gc_page.id
            end
            display_pages.last[:children].last[:children] = gchildren
          end
          display_pages.last[:children] = children
        end
      end
    end
    gon.display_pages = display_pages

    non_display_pages = []
    @wiki.pages.each do |page|
      next if rej.include?(page.id)
      non_display_pages << {title: page.title, page_id: page.id}
    end
    gon.non_display_pages = non_display_pages
  end

  def update
    @wiki = Wiki.find(params["wiki_id"])
    navs = wiki_nav_params.to_hash["tree"]
    @wiki.nav = navs
    @wiki.save
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

  def wiki_nav_params
    params.require(:nav).permit!
  end
end
