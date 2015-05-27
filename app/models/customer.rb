class Customer < ActiveRecord::Base
	include EmailHolder
	include CustomerPersonalNameHolder
  belongs_to :company

	#has_many :orders, class_name: 'Loanorder', dependent: :destroy

	#before_validation do
	#	self.email_for_index = email.downcase if email
	#end	

	validates :company_id,:store_code, :store_name,
  					:email,  presence: true

  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: ->(obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: ->(obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
	#:start_date, presence: true


	#validates :password, presence: true
   #     length:     {within: 6..30}

  has_secure_password

	def active?
		!suspended? && start_date <= Date.today &&
		(end_date.nil? || end_date > Date.today)
	end




	PREFECTURE_NAMES = %w(
    北海道
    青森県 岩手県 宮城県 秋田県 山形県 福島県
    茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県
    新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県 愛知県
    三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県
    鳥取県 島根県 岡山県 広島県 山口県
    徳島県 香川県 愛媛県 高知県
    福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県
    沖縄県
    日本国外
  )
  validates :postal_code,format: { with: /\A\d{7}\z/,allow_blank: true}
  validates :prefecture, inclusion: {in: PREFECTURE_NAMES, allow_blank: true}
end
