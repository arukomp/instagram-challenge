require 'rails_helper'

RSpec.describe User, type: :model do

  it 'allows to pass in username when creating a user' do
    user = User.create(email: 'test@test.com', password: 'password', username: 'arukomp')
    expect(user.username).to eq 'arukomp'
  end

  it 'username is required' do
    user = User.create(email: 'test@test.com', password: 'password')
    expect(user).to have(1).error_on(:username)
  end

  it 'username is unique' do
    User.create(email: 'test@test.com', password: 'password', username: 'arukomp')
    user = User.create(email: 'another@test.com', password: 'password', username: 'arukomp')
    expect(user).to have(1).error_on(:username)
  end

  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }

  it 'creates a Feed upon registration' do
    user = User.new(email: 'test@test.com', password: 'password', username: 'arukomp')
    expect{ user.save }.to change(Feed, :count).by(1)
  end

  describe 'feed' do
    it { is_expected.to have_one :feed }
  end

end
