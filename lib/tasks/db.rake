namespace :db do
  namespace :seed do
    desc "Seed a specific file"
    task :specific, [:filename] => :environment do |t, args|
      binding.pry
      seed_file_path = args[:filename] ? Rails.root.join("db/seeds.rb") : Rails.root.join("db/seeds/#{args[:entity]}.rb")

      if File.exist?(seed_file_path)
        load seed_file_path
        puts "Successfully seeded #{file}"
      else
        puts "Seed file #{file} does not exist"
      end
    end
  end
end
