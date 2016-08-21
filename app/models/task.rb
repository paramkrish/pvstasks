class Task < ApplicationRecord
	#attr_accessor :title, :category_id, :owner, :remarks, :due_date, :status, :priority
	default_scope -> { order('created_at DESC') }

	scope :status, -> (status) { where status: status }
	scope :owner, -> (owner) { where owner: owner }
	scope :priority, -> (priority) { where priority: priority }
	scope :category_id, -> (category_id) { where category_id: category_id }
	scope :close, -> (close) { where status: 0 } 
  	scope :reopen, -> (reopen) { where status: 1 }

	belongs_to :category
	validates :title, presence: true


end
