# TODO require all converters and generators

require 'thor'
require 'to_town'
require 'to_town/converter/us'
require 'to_town/generators/mongodb'

module ToTown
  class CLI < Thor

    desc "populate", "populate data to mongodb"
    def populate
      ToTown::Converter::Us.run
    end

    desc "check", "acceps two required arguments --lat and --lng, and an optional --limit"
    method_option :lat, :required => true
    method_option :lng, :required => true
    method_option :limit, :type => :numeric
    def check
      points = ToTown.check(options[:lat].to_f, options[:lng].to_f, options[:limit])
            points.each do |point|
              puts %{ #{point.name} #{point.state}\t
                      type: #{point.town_type}\t
                      latitude: #{point.latlng[0]}\t
                      longitude: #{point.latlng[1]}\t
                      land area: #{point.aland}\t
                      water area: #{point.awater}
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