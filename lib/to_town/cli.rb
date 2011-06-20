# TODO require all converters and generators

require 'thor'
require 'to_town'
require 'to_town/converter/us'
require 'to_town/generators/mongodb'

module ToTown
  class CLI < Thor

    desc "populate", "populate mongodb with US 2010 census data"
    def populate
      ToTown::Converter::Us.run
    end

    desc "check latitude longitude", "acceps two arguments latitude and longitude"
    def check(lat, lon)
      points = ToTown.check(lat.to_f, lon.to_f)
      points.each do |point|
        puts %{ #{point.name} #{point.state}\t
                latitude:#{point.latlng[0]}\t
                longitude:#{point.latlng[1]}\t
                land area:#{point.aland}\t
                water area#{point.awater}
              }
      end
    end

    desc "config", "generate database configuration file mongoid.yml"
    def config(db_name='mongo')
      case db_name
      when "mongo"
        ToTown::Generators::Mongodb.start
      end
    end

  end
end