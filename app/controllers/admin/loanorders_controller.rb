class Admin::LoanordersController < Admin::Base
	def index
		#@search_form = Admin::LoanorderSearchForm.new
		@max = Loanorder.maximum(:update_datetime)
  	@loan = Loanorder.select(:company_code,:company_name).uniq
  	#@loanorders = @loanorders.page(params[:page])
  	@search_form = Admin::LoanorderSearchForm.new(params[:search])
  	@loanorders = @search_form.search.page(params[:page])
  end

  def import
  # fileはtmpに自動で一時保存される
	  if params[:file].blank?
			redirect_to admin_loanorders_url, notice: "ファイルを選択してください。"	
		else
	  	Loanorder.import(params[:file])
		  redirect_to admin_loanorders_url, notice: "顧客データを追加しました。"
		end
	end
end
