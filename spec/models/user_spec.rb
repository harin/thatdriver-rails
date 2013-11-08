require 'spec_helper'

describe User do
  before do
    
  end

  it {should validate_uniqueness_of(:username)}

  it 'should have a role of admin or user or blank' do
    
  end


end
