module ApplicationHelper
  def markdown(text)
    Kramdown::Document.new(text, {parse_block_html: true}).to_html
  end
end
