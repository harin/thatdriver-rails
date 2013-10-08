class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  has_many :rates
  has_many :founds
  has_many :items, through: :founds
  has_many :losts
  has_many :items, through: :losts


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def found_items
    self.founds.map{|f| f.item}
      .select{|f| f}#filter out nil element

  end

  def lost_items
    self.losts.map{|l| l.item}
      .select{|f| f}#filter out nil element
  end


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
