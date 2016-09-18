class Preference < ApplicationRecord
	belongs_to :user
	
	scope :user_id, -> (user_id) { where user_id: user_id }

end
