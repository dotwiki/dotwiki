json.extract! wiki, :id, :title, :description, :official_url, :steam_id, :terms, :created_at, :updated_at
json.url wiki_url(wiki, format: :json)
