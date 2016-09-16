class Tracking < ApplicationRecord
	belongs_to :task
	scope :user_id, -> (user_id) { where user_id: user_id }
	scope :task_id, -> (task_id) { where task_id: task_id }

end
