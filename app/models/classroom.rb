class Classroom < ApplicationRecord
  belongs_to :school

  validates_presence_of :subject, null: false
end
