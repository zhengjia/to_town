require 'thor/group'

module ToTown
  module Generators
    class Mongodb < Thor::Group

      include Thor::Actions

      def genenrate
        template("mongoid_example.yml", "mongoid.yml")
      end

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

    end
  end
end