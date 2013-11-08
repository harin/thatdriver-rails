require 'spec_helper'

describe Api::V1::ApiController do

  fixtures :users

  let(:user_1) { users(:user_1) }

  describe "#get_token" do
    context "when credential is incorrect" do
      it "should response with unauthorize if no credential given" do
        get :get_token
        expect(response.status).to eq(401)
      end

      it "should response with unauthorize if wrong username or password provided" do
        get :get_token, username: "user", password:"1324"
        expect(response.status).to eq(401)
      end
    end
    context "when credential is correct" do
      before do
        @password = "12345678"
        user_1.password = @password
        user_1.save
      end

      it "should response with success" do    
        get :get_token, username: user_1.username, password: @password

        response.should be_success
      end

      it "should include authentication token" do
        get :get_token, username: user_1.username, password: @password
        response.body.should have_json_path("auth_token")
        response.body.should have_json_type(String).at_path("auth_token")
      end

      it "should include user information" do
        get :get_token, username: user_1.username, password: @password
        response.body.should have_json_path("user")
        response.body.should have_json_path("user/username")
        response.body.should have_json_path("user/last_name")
        response.body.should have_json_path("user/first_name")
        response.body.should have_json_path("user/email")
        response.body.should have_json_path("user/phone")
      end
    end
  end
  

  describe "#register" do
    

  end
end