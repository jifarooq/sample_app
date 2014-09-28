# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  
  #ensure email uniqueness.  Needed because not all db adapters use case-sensitive indicies
  before_save { self.email.downcase! }
  before_save :create_remember_token
  
  #validate name
  validates :name, presence: true, length: { maximum: 50 }
  
  #validate email address
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  
  #validate password
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  private
    
    #maintains user signin status
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end

