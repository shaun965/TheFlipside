class ViewYear
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :location

  field :start_year,     type: String, default: 2015
  field :end_year,       type: String, default: 2015

end