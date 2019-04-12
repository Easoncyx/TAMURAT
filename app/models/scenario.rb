class Scenario < ApplicationRecord
  belongs_to :creator, :foreign_key => :user_id, :class_name => "User"
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }

  def create_previlege(a)
    @privilege = Privilege.new(scenario_id: self.id, user_id: a)
    @privilege.save
  end

end
