class Scenario < ApplicationRecord
  has_many :privileges, class_name: "Privilege", foreign_key: "scenario_id", dependent: :destroy
  has_many :users, through: :privileges
  has_many :scenario_weights, class_name: "ScenarioWeight", foreign_key: "scenario_id", dependent: :destroy
  has_many :companys, through: :scenario_weights

  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }

  def cal_scenario_score()
    total_score = 0
    weisum = 0
    self.scenario_weights.each do |wei|
      company = Company.find_by_id(wei.company_id)
      if company.validated
        total_score += company.score * wei.weight
        weisum += wei.weight
      end
    end
    self.score = total_score / weisum
    self.save
  end
end
