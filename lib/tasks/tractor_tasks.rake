namespace :tractor do
  namespace :install do
    desc "Copy migrations from Tractor to the parent app"
    task :migrations do
      # Ensure the Rails environment is loaded
      ENV["RAILS_ENV"] ||= "development"
      require "rails/generators"

      # Define the source and destination paths
      source_path = File.expand_path("../../db/migrate", __dir__)
      destination_path = Rails.application.root.join("db/migrate")
      puts "destination_path: #{destination_path}"
      puts "source_path: #{source_path}"

      # Ensure the destination directory exists
      FileUtils.mkdir_p(destination_path)

      # Copy each migration file
      Dir.glob("#{source_path}/*.rb").each do |file|
        filename = File.basename(file)
        destination_file = destination_path.join(filename).to_s  # Convert to string

        if File.exist?(destination_file)
          puts "Migration #{filename} already exists in the parent app. Skipping."
        else
          FileUtils.cp(file, destination_file)
          puts "Copied migration #{filename} to the parent app."
        end
      end
    end
  end
end