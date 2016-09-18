class User < ActiveRecord::Base
  attr_accessor :password
  has_many :tasks
  has_one :preference
  mount_uploader :avatar, AvatarUploader

  before_save :encrypt_password, :downcase_fields
  after_save :clear_password
  after_create :insert_preference_record

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  USERNAME_REGEX = /[A-Z]+/i
  #validates :customer_id , :uniqueness => true
  validates :username, :presence => { :message => "is taken already"  } , :uniqueness => { :message => "not unique"  }, :length => { :in => 3..20 , :message => "keep it between 1 and 20 characters only." }
  validates_format_of :username, :with => /\A(\w+)\Z/i
  validates :email, :presence => { :message => "cant be blank" }, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create
  validates :pin, numericality: { less_than_or_equal_to: 999999 }

def encrypt_password
  if password.present?
    self.salt = BCrypt::Engine.generate_salt
    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
  end
end

def insert_preference_record
  @user = User.last
  preference = Preference.new(user_id:@user.id)
  preference.save!
end


def downcase_fields
  self.username.downcase!
  self.email.downcase!
end


def clear_password
  self.password = nil
end

def self.authenticate(username_or_email="", login_password="")
  if  EMAIL_REGEX.match(username_or_email)    
    user = User.find_by_email(username_or_email)
  else
    user = User.find_by_username(username_or_email)
  end
  if user && user.match_password(login_password)
    return user
  else
    return false
  end
end   

def match_password(login_password="")
  encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
end


end