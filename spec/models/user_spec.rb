require 'spec_helper'

describe User do
  before(:each) do
    User.delete_all
  end

  it 'must have a unique username' do
    user1 = FactoryGirl.build(:user, email:"test1@test.com")
    user2 = FactoryGirl.build(:user, email:"test2@test.com")

    (user1.save).should be_true

    (user2.save).should be_false


  end

end
