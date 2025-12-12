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


  def houston_cms_importmap_tags(entry_point = "application")
    # Allow host app to add custom admin JS
    if File.exist?(Rails.root.join("app/javascript/admin_custom.js"))
      HoustonCms.config.importmap.pin "admin_custom", to: "admin_custom.js"
    end
    
    tags = [
      javascript_inline_importmap_tag(HoustonCms.config.importmap.to_json(resolver: self)),
      javascript_importmap_module_preload_tags(HoustonCms.config.importmap),
      javascript_import_module_tag(entry_point)
    ]
    
    # Include admin_custom if it exists
    if File.exist?(Rails.root.join("app/javascript/admin_custom.js"))
      tags << javascript_import_module_tag("admin_custom")
    end
    
    safe_join tags, "\n"
  end

  def marksmith_options(f, field_name)
    {
      gallery: {
        enabled: true,
        open_path: "/admin/medias/attach",
        turbo_frame: 'houston-cms-modal-wrap',
        params: {
          resource_name: f.object.model_name.singular,
          controller_name: "marksmith",
          controller_selector: "[data-unique-selector=#{f.object.model_name.singular}_#{f.object.id}_#{field_name}]",
          record_id: f.object&.to_param,
        }
      },
      controller_data_attributes: {
        unique_selector: "#{f.object.model_name.singular}_#{f.object.id}_#{field_name}",
      }
    }
  end
  
end
