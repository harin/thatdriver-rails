require 'spec_helper'

describe "basic API" do
  it 'should give authentication token from username and password' do
    last_name = 'freeman'
    user = FactoryGirl.create(:user, last_name: last_name)

    get "/api/v1/get_token?username=#{last_name}&password=123456"

    expect(response).to be_success            # test for the 200 status-code
    json = JSON.parse(response.body)
    expect(json['auth_token']).to eq(user.authentication_token)
  end

  it 'should allow user to register' do

    params = FactoryGirl.attributes_for(:user, first_name:'Ed', last_name:'Edd')
    post '/api/v1/register', params
    #test 200 status code
    expect(response).to be_success

    #new_user should exist/ not nil
    new_user = User.find_by(first_name:params[:first_name])
    new_user.should be

    #response should contain auth_token
    json = JSON.parse(response.body)

    expect(json['auth_token']).to eq(new_user.authentication_token)
  end

  it 'should not allow user to register the same username' do 
    params = FactoryGirl.attributes_for(:user, first_name:'Ed', last_name:'Edd')
    post '/api/v1/register', params
    #test 200 status code

    expect(response).to be_success

    #response success should be false
    json = JSON.parse(response.body)

    (json['success']).should be_false
  end


end