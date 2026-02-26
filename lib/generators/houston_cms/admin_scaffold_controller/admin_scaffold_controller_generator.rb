require "rails/generators/named_base"

module HoustonCms
  module Generators
    class AdminScaffoldControllerGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

      def create_controller_file
        template "controller.rb", "app/controllers/admin/#{file_name.pluralize}_controller.rb"
      end

      def create_view_files
        empty_directory "app/views/admin/#{file_name.pluralize}"

        %w[index show new edit _form].each do |view|
          template "#{view}.html.erb", "app/views/admin/#{file_name.pluralize}/#{view}.html.erb"
        end
      end

      def add_routes
        route "namespace :admin do\n    resources :#{file_name.pluralize}\n  end"
      end

      private

      def controller_class_name
        "Admin::#{class_name.pluralize}Controller"
      end

      def singular_table_name
        file_name
      end

      def plural_table_name
        file_name.pluralize
      end

      def index_helper
        plural_table_name
      end

      def human_name
        class_name
      end

      def route_url
        plural_table_name
      end
    end
  end
end
