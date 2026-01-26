namespace :houston do
  namespace :admin do
    desc "Generate admin controller for existing model"
    task :controller, [ :model_name ] => :environment do |t, args|
      model_name = args[:model_name]

      unless model_name
        puts "Usage: rake houston:admin:controller[ModelName]"
        puts "Example: rake houston:admin:controller[Boat]"
        exit 1
      end

      begin
        # Get model to determine attributes
        model_class = model_name.classify.constantize
        attributes = model_class.columns.reject { |col| %w[id created_at updated_at].include?(col.name) }
        attr_strings = attributes.map { |col| "#{col.name}:#{col.type}" }

        command = "bin/rails generate houston_cms:admin_scaffold_controller #{model_name} #{attr_strings.join(' ')} --model-name=#{model_name.classify}"
        puts "Running: #{command}"
        system(command)
      rescue NameError
        puts "Model #{model_name.classify} not found. Make sure it exists first."
        exit 1
      end
    end
  end
end
