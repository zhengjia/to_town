# store the imported file so it won't be imported again

module ToTown

  class DataMigration

    include Mongoid::Document
    include Mongoid::Timestamps

    field :filename

  end

end