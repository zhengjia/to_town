require 'iconv'
require 'to_town/point'
require 'to_town/data_migration'
require 'to_town/db_connection'

module ToTown

  module Converter

    class Us
      FILE_NAME     = "Gaz_places_national.txt"
      FILE_LOCATION = File.expand_path("../../../raw_data/#{FILE_NAME}" , File.dirname(__FILE__))

      def self.run(dry = 0)
        iconv = Iconv.new('UTF-8//IGNORE', 'UTF-8')
        if ToTown::DataMigration.where(:filename => FILE_NAME).empty?
          if dry == 0
            File.open(FILE_LOCATION, "r") do |file|
              # pass the title
              file.gets
              while line = file.gets
                line = iconv.iconv(line) unless line.valid_encoding?
                data = line.chomp.split(/\t/)
                name_town_type = data[3].split(/ ((?=[[:lower:]])|CDP)/)
                ToTown::Point.create(:state => data[0], :geoid => data[1], :ansicode => data[2], :name => name_town_type[0], :town_type => (name_town_type-[name_town_type[0]]).join, :aland => data[4], :awater => data[5], :latlng => [data[8].to_f, data[9].to_f] )
              end # end while
            end # end File.open
          end # end if dry == 0
          ToTown::DataMigration.create(:filename => FILE_NAME)
        end # end if
      end

    end

  end

end