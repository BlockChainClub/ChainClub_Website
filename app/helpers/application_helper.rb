module ApplicationHelper
  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm"
  end

  def render_user_avatar(user, size)
    if user.avatar.present?
      user.avatar
    else
      avatar_url(user, size)
    end
  end


  #定义高亮显示功能的helper方法，所有model公用，目前除site外，均只搜索title，site搜索的是name,后期修改字段

  def render_highlight_content(modle_name,query_string)

    excerpt_cont = excerpt(modle_name.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end

  def can_editor?
    current_user && current_user.is_editor?
  end

  # 定义Markdown

  def to_markdown(text)
      html_render_options = {
        filter_html:     true, # no input tag or textarea
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow' }
      }

      markdown_options = {
        autolink:           true,
        fenced_code_blocks: true,
        lax_spacing:        true,
        no_intra_emphasis:  true,
        strikethrough:      true,
        superscript:        true
      }

      renderer = Redcarpet::Render::HTML.new(html_render_options)
      markdown = Redcarpet::Markdown.new(renderer, markdown_options)
      raw markdown.render(text)
    end
end
