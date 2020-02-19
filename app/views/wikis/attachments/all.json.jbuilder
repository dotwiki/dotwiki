json.array! @attachments do |atc|
  json.id atc.id
  json.file atc.file.url
  json.thumbnail resize_climage(atc.file.url, "c_fit,w_50,h_50")
  json.shortcode atc.shortcode
  json.size number_to_human_size(atc.file.size)
  json.created_at atc.created_at.strftime("%Y/%m/%d")
end