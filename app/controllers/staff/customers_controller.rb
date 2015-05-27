class Staff::CustomersController < Staff::Base
 	def index
    @customer = Customer.order(:company_name)
    @customer = @customer.page(params[:page])
  end

  def show
    customer = Customer.find(params[:id])
    redirect_to [ :edit, :admin, customer ]
  end
  def print
    @customer = Customer.find(params[:id])
  end
  def new
    @customer = Customer.new
  end

  def edit
  	@customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash.notice = 'お客様情報を新規登録しました。'
      redirect_to :admin_customers
    else
      render action: 'new'
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.assign_attributes(customer_params)
   # if @customer.valid?
	    if @customer.save
	      flash.notice = 'お客様情報を更新しました。'
	      redirect_to :admin_customers
	    else
	      render action: 'edit'
	    end
	 # else
	 #  	render action: 'edit'
	 # end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy!
    flash.notice = 'お客様情報を削除しました。'
    redirect_to :admin_customers
  end
  def confirm
    @customer = Customer.new(customer_params)
    if params[:commit]
      if @customer.valid?
        render action: 'confirm'
      else
        flash.now.alert = '入力に誤りがあります。'
        render action: 'new'
      end
    else
        render action: 'new'
    end
  end

  private
  def customer_params
  	params.require(:customer).permit(
  		:company_code,:company_name, :top_family_name, :top_given_name, :top_family_name_kana, :top_given_name_kana,
  		:staff_family_name, :staff_given_name, :staff_family_name_kana, :staff_given_name_kana,
  		:zip_code, :prefecture, :city, :address1, :address2, :telephone_number, :mobilephone_number,
  		:fax_number, :email, :password,:start_date,:end_date,:suspended
  		)
  end
end
