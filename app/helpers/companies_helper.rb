module CompaniesHelper
  # given company instance, get user name
  def get_company_name company
    User.find_by_id(company.user_id).name
  end
  # given company instance, get user login_id
  def get_company_login_id company
    User.find_by_id(company.user_id).login_id
  end

  def ancestor?(company1, company2)
    if company2.parent_id
      if company1 == company2.parent
        return true
      else
        return ancestor?(company1, company2.parent)
      end
    end
  end
end
