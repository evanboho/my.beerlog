class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :ratings,          :dependent => :destroy
  has_many :authentications,  :dependent => :destroy
  
  validates_presence_of :email
  validates :bio, :length => { :maximum => 200 }
  validates :location, :length => { :maximum => 30 }
  
  def build_auth(auth)
    authentications.build(:provider => auth['provider'], :uid => auth['uid'])
  end
  
end
