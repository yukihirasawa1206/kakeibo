class Account_data
	include ActiveModel::Model

	attr_accessor :category_id, :genre_id,:amount,:date, :comment, :name, :place
	validates :category_id, presence: true
	validates :genre_id, presence: true
	validates :amount, presence: true
	validates :date, presence: true
	validates :comment, length: {maximum: 100}
	validates :name, length: {maximum: 100}
	validates :place, length: {maximum: 100}


	def check_attributes
		return false if invalid?
		true
	end

end
