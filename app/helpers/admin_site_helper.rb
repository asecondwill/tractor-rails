module AdminSiteHelper
  def snippet(slug, content_type: 'standard')  
    snippet_record = Rails.cache.fetch("snippet/#{slug}") do
      Snippet.friendly.find_by(slug: slug)
    end  
    snippet_output(snippet_record, content_type, slug)     
  end

  def snippet_or_create(slug, content, content_type: 'standard')   
    snippet_record_from_cache = Rails.cache.fetch("snippet/#{slug}") do
      # Try to find existing snippet
      snippet_record = Snippet.friendly.find_by(slug: slug)
      puts "existing snippet: #{snippet_record.inspect}"
      # If not found, create it
      if snippet_record.nil?
        snippet_record = Snippet.create!(
          slug: slug,
          name: slug.humanize,
          content: content,
          user_id: User.first.id
        )
        puts "Created snippet: #{snippet_record.inspect}"                
      end
      snippet_record
    end
    snippet_output(snippet_record_from_cache, content_type, slug)    
  end 

  def snippet_output(snippet_record, content_type, slug)
    if snippet_record        
      if content_type == 'standard'
        "<div class='snippet admin-link-wrap md'>#{admin_link(snippet_record)}#{sc(md(snippet_record.content.html_safe)).html_safe}</div>".html_safe
      elsif content_type == 'text-only'
        strip_tags(snippet_record.content)
      else    
        "<div class='snippet admin-link-wrap md'>#{admin_link(snippet_record)}#{strip_tags(snippet_record.content)}</div>".html_safe      
      end
    else
      if content_type == 'text-only'
        "Snippet Missing"
      else
        "<div class='snippet-missing'>Snippet #{slug} is missing</div>".html_safe
      end
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
      config.template_path = HoustonCms::Engine.root.join("app/views/shortcode_templates").to_s
      
      config.self_closing_tags = %i[youtube mailchimp advisor]
      config.use_attribute_quotes = false
    end
    # Add the gem's template path to Shortcode::Template - note, made up.  doesnt work.
    #Shortcode::Template.template_paths << HoustonCms::Engine.root.join("app/views/shortcode_templates").to_s

    raw shortcode.process(s)
  end

end