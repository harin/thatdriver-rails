require 'spec_helper'

describe User do
  before do
    
  end

  it {should validate_uniqueness_of(:username)}


  context "role validation" do
    it 'should allow blank role' do
      user = User.new(username:"test", password:"123456")
      expect(user.save).to be_true
    end

    it { should ensure_inclusion_of(:role).in_array(['admin', 'user']) }

    it 'should set role to user if left blank' do 
      user = User.new(username:"test2", password:"123456")

      user.save
      expect(user.role).to eq("user")
    end
  end

  


end
