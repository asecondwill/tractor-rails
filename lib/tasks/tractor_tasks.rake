namespace :tractor do
  namespace :install do
    desc "Copy migrations from MyGem to the parent app"
    task :migrations do
      ENV["RAILS_ENV"] ||= "development"
      require "rails/generators"
      require "rails/generators/rails/migration/migration_generator"
      Rails::Generators::MigrationGenerator.source_root File.expand_path("../../db/migrate", __dir__)
      Rails::Generators::MigrationGenerator.start(["create_my_gem_tables"])
    end
  end
end