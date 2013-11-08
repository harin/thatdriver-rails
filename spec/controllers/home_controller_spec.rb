require 'spec_helper'

describe HomeController do
  fixtures :users

  let(:user_1) { users(:user_1)}

  before do
    sign_in user_1
    
  end
  
  describe "#index" do
    it "should be success" do
      get :index
      response.should be_success

    end
  end  
  
end