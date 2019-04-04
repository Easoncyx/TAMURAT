class User < ApplicationRecord
  attr_accessor :activation_token, :reset_token
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
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # 创建并赋值激活令牌和摘要
  def create_activation_digest
    #   self.activation_token  = User.new_token
    #   self.activation_digest = User.digest(activation_token)
    self.activation_token = User.new_token
    update_attribute(:approved,    true)
    update_attribute(:activation_digest, User.digest(self.activation_token))
    update_attribute(:activated_at, Time.zone.now)
  end
  
  # 设置密码重设相关的属性
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # 如果密码重设请求超时了，返回 true
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  #subcompany relationship
  has_many :parent_company_links, :foreign_key => :parent_company_user_id, :dependent => :destroy, :class_name => "Subcompany"
  has_one :child_company_links, :foreign_key => :child_company_user_id, :dependent => :destroy, :class_name => "Subcompany"
  has_many :parent_companies, :through => :parent_company_links
  has_one :child_companies, :through => :child_company_links
  
  private
    # 把电子邮件地址转换成小写
    def downcase_email
      self.email = email.downcase
    end

end
