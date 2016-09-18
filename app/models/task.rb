class Task < ApplicationRecord
	#attr_accessor :title, :category_id, :owner, :remarks, :due_date, :status, :priority
	has_many :comments, dependent: :destroy
	has_many :trackings, dependent: :destroy
	default_scope -> { order('created_at DESC') }

	scope :status, -> (status) { where status: status }
	scope :user_id, -> (user_id) { where user_id: user_id }
	scope :assignedto_id, -> (assignedto_id) { where assignedto_id: assignedto_id }
	scope :priority, -> (priority) { where priority: priority }
	scope :category_id, -> (category_id) { where category_id: category_id }
	scope :close, -> (close) { where status: 0 } 
  	scope :reopen, -> (reopen) { where status: 1 }

	belongs_to :category
	belongs_to :user
	validates :title, presence: true
	validates_length_of :title, :in => 5..100



end
