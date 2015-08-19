class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :posts, dependent: :destroy
  has_many :history, dependent: :destroy
  has_many :view_year, dependent: :destroy

  field :lattitude,       type: Float
  field :longitude,       type: Float
  field :dir_longitude,   type: Float
  field :dir_lattitude,   type: Float
  field :zoom,            type: Float
  field :pitch,           type: Float
  field :heading,         type: Float

end