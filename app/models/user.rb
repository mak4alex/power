class User < ActiveRecord::Base
  attr_accessor :login
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :validate_username

  def validate_username
    if User.where(email: name).exists?
      errors.add(:name, :invalid)
    end
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    conditions[:email].downcase! if conditions[:email]
    if login = conditions.delete(:login)
      where(conditions.to_hash).where([
        "lower(name) = :value OR lower(email) = :value", 
        { value: login.downcase }]
      ).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
  
  
  def add_favourite(post)
    Favourite.create(user: self, post: post)
  end
  
  def remove_favourite(post)
    Favourite.delete_all(user: self, post: post)
  end
  
  def has_in_favourite?(post)
    Favourite.exists?(user: self, post: post)
  end
  
end
