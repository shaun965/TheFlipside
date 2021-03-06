class User
  include Mongoid::Document
  include Mongoid::Paperclip
  # after_create :create_image_binary
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_save :create_image_binary,
    if: Proc.new { |user| user.avatar.path && !user.image_binary }

  has_many :posts
  has_many :comments
  has_many :historys, dependent: :destroy
  has_many :view_years, dependent: :destroy
  has_mongoid_attached_file :avatar, :styles => { :thumb => "50x50" }, :default_url => ActionController::Base.helpers.image_path("missing.jpg")#{}"/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :first_name,              type: String
  field :last_name,               type: String


  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  field :image_binary,       type: String
  field :small_image,        type: String


  def create_image_binary
    # binding.pry 
    begin

      image_file = self.avatar.path
      file = File.read(image_file)
      image_data = Base64.encode64(file).gsub(/\n/, "")
      self.image_binary = image_data

      image_file2 = self.avatar.path(:thumb)
      file2 = File.read(image_file2)
      image_data2 = Base64.encode64(file2).gsub(/\n/, "")
      self.small_image = image_data2
      save
    rescue
      puts 'image stuff didnt work'
    end
  end



  def email_required?
    false
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
end
