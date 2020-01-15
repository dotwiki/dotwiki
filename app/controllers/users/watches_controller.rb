class Users::WatchesController < ApplicationController
  def update
    watching_wiki = current_user.watches.find_by(wiki_id: params["wiki_id"])
    unless watching_wiki
      current_user.watches.create(wiki_id: params["wiki_id"])
      render body: nil, status: 201
    else
      watching_wiki.destroy!
      render body: nil, status: 200
    end
  end
end
