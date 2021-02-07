require 'rails_helper'

RSpec.describe "patients/show", type: :view do
  before(:each) do
    create(:user, emergency_staff: true)
    @facility = create(:facility)
    @patient = assign(:patient, build_stubbed(:patient,
      first_name: "John",
      middle_name: "Quincy",
      last_name: "Doe",
      medical_record: 21000,
      gender: 'male'
    ))
    create(:admission,
       patient: @patient,
       facility: @facility,
       observations: [create(:observation, description: 'no soft tissues were damaged'),
                      create(:observation, description: 'and appears to be a fracture')],
       diagnoses: [create(:diagnosis), create(:diagnosis)],
       symptoms: [create(:symptom), create(:symptom, description: "his leg is bleeding")])
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
