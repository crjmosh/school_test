class School < ApplicationRecord
	has_many :classrooms

	validates_presence_of :name
	validates_uniqueness_of :name
end
