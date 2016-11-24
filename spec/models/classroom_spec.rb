require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe 'associations' do
  	it { should belong_to :school }
  end

  describe 'validations' do
  	it { should validate_presence_of(:subject) }
  end
end
