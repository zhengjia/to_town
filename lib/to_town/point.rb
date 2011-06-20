require 'mongoid'

module ToTown

  class Point

    include Mongoid::Document

    field :latlng, :type => Array
    field :name
    field :town_type
    field :state
    field :geoid
    field :ansicode
    field :aland, :type => Integer
    field :awater, :type => Integer

    index [[:latlng, Mongo::GEO2D]]
  end

end