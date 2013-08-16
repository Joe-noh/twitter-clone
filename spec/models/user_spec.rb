require_relative '../spec_helper'

describe User do

  before :all do
    @john = Fabricate :john
    @bob  = Fabricate :bob

    @status = Fabricate :status
  end

  after :all do
    @john.destroy
  end

  describe 'should be able to' do

    it 'create a status' do
      @john.add_status @status

      expect(@john.statuses).to eql [@status]
    end

    it 'follow other users' do
      @john.add_followee @bob

      expect(@john.followees).to eql [@bob]
    end

    it 'know the users who follow him/her' do
      pending 'john.followees'
    end

    it 'know the users whom he/she follows' do
      pending 'john.followers'
    end

    it 'get own timeline' do
      pending 'john.timeline #=> [status1, status2, ... ]'
    end

    it 'be authorized' do
      pending 'be authorized by username and password'
    end
  end
end
