require 'spec_helper'

describe User do
  it 'has a location' do
    user = User.new
    user.should respond_to(:location)
  end
end