module AdminSiteHelper
  def snippet(slug)
    snippet = Snippet.friendly.find_by(slug: slug)   
    if snippet 
      "<div class='snippet admin-link-wrap'>#{admin_link(snippet)}#{md(snippet.content)}</div>".html_safe
    else
      "<div class='snippet-missing'>Snippet #{slug} is missing</div>".html_safe
    end
  end

  def admin_link(record)
    if record
      if current_user && current_user.site_admin && current_user.debug 
        "<a class='admin-link' href='/admin/#{record.class.table_name}/#{record.id}/edit' target='_blank'><span>edit</span></a>".html_safe
      end
    end
  end

  def md(s)    
    return unless s
    a = GitHub::Markup.render('README.markdown', s).html_safe
    a.gsub!('{cite}', '<cite>')
    a.gsub!('{/cite}', '</cite>')
    a.gsub!('{br}', '<br>')
    a.gsub!('.</strong>', '.</strong>&nbsp;')
    a.html_safe
  end
end