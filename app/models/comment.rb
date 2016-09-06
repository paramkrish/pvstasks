class Comment < ApplicationRecord
  belongs_to :task
  	validates :comments, :presence => { :message => "Comment is required"  }
	validates_length_of :comments, :in => 5..1000

end
