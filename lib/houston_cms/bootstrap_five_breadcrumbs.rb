# frozen_string_literal: true

module HoustonCms
  class BootstrapFiveBreadcrumbs < BreadcrumbsOnRails::Breadcrumbs::Builder
    def render
      @context.content_tag(:ol, class: 'breadcrumb') do
        @elements.collect do |element|
          render_element(element)
        end.join.html_safe
      end
    end

    def render_element(element)
      current = @context.current_page?(element.path)
      @context.content_tag(:li, class: "breadcrumb-item #{'active' if current}", "aria-current": (current ? "page" : nil)) do
        if current
          link_or_text = compute_name(element)
        else
          link_or_text = @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
        end
        link_or_text
      end
    end
  end
end

# Make it available globally as BootstrapFiveBreadcrumbs for backward compatibility
BootstrapFiveBreadcrumbs = HoustonCms::BootstrapFiveBreadcrumbs
