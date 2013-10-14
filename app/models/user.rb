class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  has_many :found_items, class_name: "Item", foreign_key: 'founder_id'
  has_many :lost_items, class_name: "Item", foreign_key: 'loser_id'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# authentication methods
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
  
end
