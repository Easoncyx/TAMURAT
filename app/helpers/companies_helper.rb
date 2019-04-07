module CompaniesHelper
  def get_company_name company
    User.find_by_id(company.user_id).name
  end
end
