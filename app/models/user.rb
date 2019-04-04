class User < ApplicationRecord
  attr_accessor :activation_token
  before_save   :downcase_email
  #before_create :create_activation_digest
  has_many :scenarios, dependent: :destroy

  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
                    # uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :login_id, presence: true, uniqueness: true
  VALID_ROLE_REGEX = /Decision Maker|Company Representative|Validator|Administrator/i
  validates :role, presence: true, format: { with: VALID_ROLE_REGEX }
  

  
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # def User.new_token
  #   SecureRandom.urlsafe_base64
  # end
  
  # def User.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end
  
  private
    # 把电子邮件地址转换成小写
    def downcase_email
      self.email = email.downcase
    end

    # 创建并赋值激活令牌和摘要
    # def create_activation_digest
    #   self.activation_token  = User.new_token
    #   self.activation_digest = User.digest(activation_token)
    # end
  
end
