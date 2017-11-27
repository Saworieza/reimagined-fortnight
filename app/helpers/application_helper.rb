module ApplicationHelper
	def parse(content)
    content = content.gsub(/(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i) do |match|
      link_to(match, hashtag_path(match.gsub('#','')), class: 'hashtags')
    end

    content.gsub(/(@\w+-?\w+)/) do |match|
      link_to(match, user_path(match.gsub('@','')), class: 'mention')
    end
  end

  def current_user?(user)
    user == current_user
  end

  # the next two methods are  used by the view to render your mention, decorated with markdown whicj is kinda what my parse method aboved does.
  def markdown(text)
    renderer = Redcarpet::Render::SmartyHTML.new(filter_html: true, 
                                                 hard_wrap: true, 
                                                 prettify: true)
    markdown = Redcarpet::Markdown.new(renderer, markdown_layout)
    markdown.render(sanitize(text)).html_safe
  end

  def markdown_layout
    { autolink: true, space_after_headers: true, no_intra_emphasis: true,
      tables: true, strikethrough: true, highlight: true, quote: true,
      fenced_code_blocks: true, disable_indented_code_blocks: true,
      lax_spacing: true }
  end

end
