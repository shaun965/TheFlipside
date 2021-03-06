class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :location
  belongs_to :user
  has_many :comments, dependent: :destroy

  field :text,       type: String



end