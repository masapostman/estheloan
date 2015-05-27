class Staff::LoanorderSearchForm
	include ActiveModel::Model

	attr_accessor :company_name, :company_code


	def search
		rel = Loanorder
		if company_name.present?
			rel = rel.where(company_name: company_name)
		end
		rel
	end
end