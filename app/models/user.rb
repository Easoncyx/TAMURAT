class User < ApplicationRecord
  attr_accessor :activation_token, :reset_token
  before_save   :downcase_email
  #before_create :create_activation_digest
  has_many :privileges, class_name: "Privilege", foreign_key: "user_id", dependent: :destroy
  has_many :scenarios, through: :privileges

  #subcompany relationship

  has_many :answers, :foreign_key => :validator_id, :class_name => "Answer"
  # company
  has_one :company, :foreign_key => :user_id, :class_name => "Company", :dependent => :destroy

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

# virtual attribute for importing company by admin
  # # setter
  # def parent_login_id=(value)
  #   @parent_login_id = value
  # end
  # #getter
  # def parent_login_id
  #   @parent_login_id
  # end

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

  # 用户得到批准后添加到company数据库
  def create_company
    if self.role == "Company Representative"
      if !Company.exists?(user_id: self.id)
        @company = Company.new(user_id: self.id)
        if @company.save
          # add all scenarios to scenario_weight table
          @scenarios = Scenario.all
          @scenarios.each do |s|
            @company.scenarios << s
          end
          # flash[:info] = "Company saved!"
        else
          # not possible
          # flash[:danger] = "Company saved failed!!"
        end
      else
        @company = Company.find_by(user_id: self.id)
        # add all scenarios to scenario_weight table
        @scenarios = Scenario.all
        @scenarios.each do |s|
          if !@company.scenarios.include?(s)
            @company.scenarios << s
          end
        end
      end
    end
  end

  def self.search(search)
    if search
      User.where("name ILIKE ? OR email ILIKE ?", "%#{search}%" , "%#{search}%")
    else
      User.all
    end
  end


  def create_scenario(sn)
    scenarios << sn
  end

  def delete_scenario(sn)
    scenarios.delete(sn)
  end

  def has_scenario?(sn)
    scenarios.include?(sn)
  end

  private
    # 把电子邮件地址转换成小写
    def downcase_email
      self.email = email.downcase
    end

end
