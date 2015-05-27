class Loanorder < ActiveRecord::Base
	#self.inheritance_column = nil

	#belongs_to :member, class_name: 'StaffMember', foreign_key: 'staff_member_id'

	#belongs_to :customer, class_name: 'Customer', foreign_key: 'customer_id'

  def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        # 売上NO(row(1)が見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
        if row[0] == '9'
          order = find_by(sales_no: row[1])
          if order != nil
            order.destroy!
          end
        else
          row[14] = DateTime.parse(row[14])
          order = find_by(sales_no: row[1]) || new
          # CSVからデータを取得し、設定する
          order.attributes = row.to_hash.slice(*updatable_attributes)
          # 保存する
          order.save!
        end
      end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["update_flg","sales_no","company_code", "company_name","store_code","store_name", "order_date", "receipt_number",
      "user_name", "loan_company_name","area",
      "application_money","status","charge_date", "update_datetime"]
  end
end
