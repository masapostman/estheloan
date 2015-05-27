class Customer::Authenticator
  def initialize(customer)
    @customer = customer
  end

  def authenticate(raw_password)
    @customer &&
      @customer.password_digest &&
      BCrypt::Password.new(@customer.password_digest) == raw_password
  end
end
