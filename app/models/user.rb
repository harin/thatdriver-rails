class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  after_create :ensure_authentication_token
  
  has_many :rates
  has_many :found_items, class_name: "Item", foreign_key: 'founder_id'
  has_many :lost_items, class_name: "Item", foreign_key: 'loser_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true
  validates :role, inclusion: ['admin','user'], allow_blank:true

  after_initialize :custom_init
  def custom_init
    #set default for returned to be false

    #set province default to bangkok
    self.role = 'user' if (self.has_attribute? :role) && self.role.nil?
  end

# authentication methods
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
  
  def summary
    {
      username:self.username,
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email,
      phone: self.phone
    }
  end
  
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end


  
end
