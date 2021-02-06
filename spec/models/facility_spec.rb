require 'rails_helper'

RSpec.describe Facility, type: :model do

  describe "associations" do
    it { should have_many :admissions }
    it { should have_many(:patients).through(:admissions) }
  end

  describe "validations" do
    it { validate_presence_of :name }
  end

end
