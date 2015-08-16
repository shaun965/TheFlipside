class History
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :location

  field :address,     type: String
  field :year,        type: Integer


end