class Customer::LoanordersController < Customer::Base
	def index
		@max = Loanorder.maximum(:update_datetime)
		@customer = Customer.where(company_id: session[:company_code])
		@company_code = session[ :company_code]	
		@search_form = Customer::LoanorderSearchForm.new(params[:search])
		#@total = @search_form.search(session[:company_code]).select(sum(application_money))
		@loanorders = @search_form.search(session[ :company_code]).page(params[:page]).per(18)
		@total = @search_form.search(session[ :company_code]).group(:company_id).sum(:application_money)
	end

end
