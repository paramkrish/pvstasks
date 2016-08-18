class Category < ApplicationRecord
	has_many :tasks
	validates :name, presence: true, uniqueness: true
	validates_length_of :name, :in => 10..100

end
