json.array! @attachments do |atc|
  json.id atc.id
  json.shortcode atc.shortcode
  json.file atc.file.url
end