require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  before do
    @patient1 = create(:patient)
    @patient2 = create(:patient, first_name: 'Jane', gender: 'female')
  end

  # the challenge is only concerned with the #index and #show controller actions

  describe "GET index" do
    before do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "assigns @patients" do
      assert_equal assigns(:patients), [@patient1, @patient2]
    end

    it "renders the index template" do
      assert_template :index
    end
  end

  describe "GET show" do
    before do
      get :show, params: { id: @patient2.id }
      expect(response).to have_http_status(:ok)
    end

    it "assigns @patient" do
      assert_equal assigns(:patient), @patient2
    end

    it "renders the show template" do
      assert_template :show
    end
  end
end
