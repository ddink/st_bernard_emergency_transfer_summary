require 'rails_helper'

RSpec.describe "patients/show", type: :view do
  before(:each) do
    @patient = assign(:patient, build_stubbed(:patient,
      first_name: "John",
      middle_name: "Quincy",
      last_name: "Doe",
      medical_record: 21000,
      gender: 'male'
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/John/)
  expect(rendered).to match(/Quincy/)
    expect(rendered).to match(/Doe/)
    expect(rendered).to match(/21000/)
    expect(rendered).to match(/male/)
  end
end
