namespace :db do
  namespace :seed do
    desc "Seed a specific file"
    task :specific, [:filename] => :environment do |t, args|
      seed_file_path = args[:filename].present? ? Rails.root.join("db/seeds/#{args[:filename]}") : Rails.root.join("db/seeds.rb")

      if File.exist?(seed_file_path)
        load seed_file_path
        puts "Successfully seeded #{file}"
      else
        puts "Seed file #{file} does not exist"
      end
    end
  end
end
