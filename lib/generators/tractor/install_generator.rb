module MyGem
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    def copy_migrations
      rake "tractor:install:migrations"
    end
  end
end