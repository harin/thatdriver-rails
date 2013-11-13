require 'spec_helper'

describe Api::V1::ReportsController do

  fixtures :users
  fixtures :taxis
  fixtures :reports

  let(:user_1) { users(:user_1) }
  let(:taxi_1) { taxis(:taxi_1) }
  let(:report_1) { reports(:report_1)}

  describe "#create" do
    it "should respond with success and report information" do
      desc = "test"
      action_type = 1

      post :create, description: desc, action_type: action_type, plate_no: taxi_1.plate_no, auth_token: user_1.authentication_token

      response.should be_success

      response.body.should have_json_path("success")
      response.body.should have_json_path("report/id")
      response.body.should have_json_path("report/location")
      response.body.should have_json_path("report/description")
      response.body.should have_json_path("report/action_type")
    end

    it "should respond with 422 if it failed" do
      post :create, user_1.authentication_token #no params, should raise error

      # response.should be_client_error
      expect(response.status).to eq(422)
    end
  end
  describe "#show" do
    it "should show report by id" do
      get :show, id: report_1.id, auth_token: user_1.authentication_token
      # puts response.body
      response.should be_success
      response.body.should have_json_path("report/id")
      response.body.should have_json_path("report/location")
      response.body.should have_json_path("report/description")
      response.body.should have_json_path("report/action_type")

    end
  end


  describe "#index" do
    it "should return latest report if no params given" do
      get :index, auth_token: user_1.authentication_token

      # json = parse_json response.body
      # reports = json["reports"]
      
      # first = reports.first
      # last = reports.last

      # first_time.shoul b

      response.should be_success
      response.body.should have_json_type(Array).at_path("reports")
    end
  end


end
