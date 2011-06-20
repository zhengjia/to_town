require 'to_town/generators/mongodb'

RACK_ENV ||= 'development'

unless File.exists?('mongoid.yml')
  ToTown::Generators::Mongodb.start
end

db_config = YAML::load File.open('./mongoid.yml' )
db_name = db_config[RACK_ENV]['database']
Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db(db_name)
  config.autocreate_indexes = true
end