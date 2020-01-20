# frozen_string_literal: true

buoy :wiki do |args|
  link args[:wiki].title, wiki_path(args[:wiki])
end

buoy :wiki_page do |args|
  link args[:page].title, wiki_page_path(args[:wiki], args[:page])
  parent :wiki, args
end

buoy :wiki_page_requests do |args|
  link "編集リクエスト一覧", wiki_page_requests_path(args[:wiki], args[:page])
  parent :wiki_page, args
end

buoy :wiki_page_request do |args|
  link "#{args[:request].user.name}さんの編集リクエスト", wiki_page_request_path(args[:wiki], args[:page], args[:request])
  parent :wiki_page_requests, args
end

# buoy :stories do
#   link 'Stories', stories_path
# end

# `crumb` is the alias of `buoy`.
# ex)
# crumb :stories do
#   link 'Stories', stories_path
# end

# link's first argument, it is used as I18n key and defalt value.
# The key is searched in the scope of 'buoys.breadcrumbs'.
#
# ex)
# buoy :story do |story|
#   link :story, story_path(story)
#   # same as `link I18n.t(:story, scope: 'buoys.breadcrumbs', default: story), story_path(story)`
# end

# You can also override Buoys configuration
#
# ex)
# buoy :story_tasks do |story|
#   link :story_tasks, story_tasks_path
#   pre_buoy :story, story, {link_current: true}
# end

# You can use `pre_buoy` as parent. `parent` is the alias of `pre_buoy`
#
# ex)
# buoy :story_tasks do |story|
#   link :story_tasks, story_tasks_path
#   parent :story, story
# end
