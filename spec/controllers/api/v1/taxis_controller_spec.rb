require 'spec_helper'

describe Api::V1::TaxisController do
  fixtures :taxis
  fixtures :users

  let(:user_1) { users(:user_1) }
  let(:taxi_1) { taxis(:taxi_1) }

  describe '#get_taxi' do
    it "should response with success" do
      get :get_taxi
      response.should be_success
    end
  end #end get_taxi

  describe "#rate_taxi" do
    before do

    end

    it "should require authentication" do
       post :rate_taxi, rating:1, comment:'testtesttest',user_id: user_1.id

       expect(response.status).to eq(401)
    end

    it "should let user rate taxi" do
      post :rate_taxi, vote: 1, comment:'testtesttest', user_id: user_1.id, auth_token: user_1.authentication_token, plate_no: taxi_1.plate_no

      response.should be_success
      response.body.should have_json_path("success")

      json = parse_json response.body

      json["success"].should eq(true)
    end
  end #end rate_taxi
end