class Subcompany < ApplicationRecord
  belongs_to :user
  belongs_to :parent_companies, :class_name => "User", :foreign_key => :parent_company_user_id
  belongs_to :child_companies, :class_name => "User", :foreign_key => :child_company_user_id
end
