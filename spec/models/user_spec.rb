require_relative '../spec_helper'

describe User do

  before :all do
    @lindsey = Fabricate :lindsey
    @franz  = Fabricate :franz

    @status = Fabricate.build :status
  end

  after :all do
    @lindsey.destroy
  end

  describe 'should be able to' do

    it 'create a status' do
      @lindsey.add_status @status

      expect(@lindsey.statuses).to eql [@status]
    end

    it 'follow other users' do
      @lindsey.add_followee @franz

      expect(@lindsey.followees).to eql [@franz]
    end

    it 'know the users who follow him/her' do
      pending 'lindsey.followees'
    end

    it 'know the users whom he/she follows' do
      pending 'lindsey.followers'
    end

    it 'get own timeline' do
      pending 'lindsey.timeline #=> [status1, status2, ... ]'
    end

    it 'be authorized' do
      pending 'be authorized by username and password'
    end
  end
end
