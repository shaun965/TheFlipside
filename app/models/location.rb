class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :posts, dependent: :destroy

  field :lattitude,       type: Float
  field :longitude,       type: Float
  field :dir_longitude,   type: Float
  field :dir_lattitude,   type: Float



end