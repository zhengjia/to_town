require 'to_town/point'
require 'to_town/db_connection'

module ToTown

  def self.check(lat, lng)
    # TODO validation
    # TODO add a limit
    Point.near(latlng: [ lat, lng ]).limit(20)
  end

end