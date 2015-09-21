# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'active_record/fixtures'
  fixtures_dir = File.join(Rails.root, '/test/fixtures')
  Dir.glob(File.join(fixtures_dir,'*.yml')).each do |file|
  base_name = File.basename(file, '.*')
  puts "Loading #{base_name}..."
  ActiveRecord::Fixtures.create_fixtures(fixtures_dir, base_name)
end
