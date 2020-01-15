json.extract! page, :id, :wiki_id, :title, :content, :created_at, :updated_at
json.url page_url(page, format: :json)
