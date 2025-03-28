module AdminHelper
  include Pagy::Frontend
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
  def pillify_boolean(value, yes_text = "YES", no_text = "NO")
    if value
      "<span class='badge rounded-pill text-bg-success'>#{yes_text}</span>".html_safe
    else
      "<span class='badge rounded-pill text-bg-secondary'>#{no_text}</span>".html_safe
    end
  end


  def tractor_importmap_tags(entry_point = "application")
    # puts "Import map JSON: #{Tractor.config.importmap.to_json(resolver: self)}"
    safe_join [
      javascript_inline_importmap_tag(Tractor.config.importmap.to_json(resolver: self)),
      javascript_importmap_module_preload_tags(Tractor.config.importmap),
      javascript_import_module_tag(entry_point)
    ], "\n"
  end

  
end
