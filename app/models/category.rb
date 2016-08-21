class Category < ApplicationRecord
	#attr_accessor :name

	has_many :tasks, :dependent => :nullify
	validates :name, presence: true, uniqueness: true
	validates_length_of :name, :in => 5..100

	def get_category(category_id)
		category_name = Category.find_by_id(category_id)
	end


end
