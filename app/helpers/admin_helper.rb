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

  def nested_items(items)
    items.map do |item, sub_items|
      content_tag(:div,
                  (render(item) + content_tag(
                    :div,
                    nested_items(sub_items),
                    class: "nested",
                    'data-id': item.id
                  )).html_safe,
                  class: "list-group-item ",
                  'data-id': item.id)
    end.join.html_safe
  end
end
