module ApplicationHelper
  def error_messages(errors)
    return '' if errors.empty?
    messages = errors.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
      <div class="ui icon negative message">
        <i class="remove circle icon"></i>
        <div class="content">
          <div class="header"> Failed :( </div>
          <div class="list-wrapper">
            <ul class="ui list">#{messages}</ul>
          </div>
        </div>
      </div>
    HTML

    html.html_safe
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true, 
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
