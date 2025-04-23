module AdminSiteHelper
  def snippet(slug)
    snippet = Snippet.friendly.find_by(slug: slug)   
    if snippet 
      "<div class='snippet admin-link-wrap md'>#{admin_link(snippet)}#{sc(md(snippet.content))}</div>".html_safe
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
    #a = GitHub::Markup.render('README.markdown', s).html_safe
    a = marksmithed(s)
    a.gsub!('{cite}', '<cite>')
    a.gsub!('{/cite}', '</cite>')
    a.gsub!('{br}', '<br>')
    a.gsub!('.</strong>', '.</strong>&nbsp;')
    a.html_safe
  end

  def sc(s)    
    shortcode = Shortcode.new
    shortcode.setup do |config|
      # config.block_tags = [:quote]
      # Add the gem's template path
      config.template_path = Tractor::Engine.root.join("app/views/shortcode_templates").to_s
      
      config.self_closing_tags = %i[youtube mailchimp advisor]
      config.use_attribute_quotes = false
    end
    # Add the gem's template path to Shortcode::Template - note, made up.  doesnt work.
    #Shortcode::Template.template_paths << Tractor::Engine.root.join("app/views/shortcode_templates").to_s

    raw shortcode.process(s)
  end

end