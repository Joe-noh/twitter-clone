require_relative '../spec_helper'

describe User do

  before :all do
    @franz   = Fabricate :franz
    @lindsey = Fabricate :lindsey

    @status_01 = Fabricate.build :status_01
    @status_02 = Fabricate.build :status_02
  end

  after :all do
    @franz.destroy
    @lindsey.destroy
  end

  describe 'should be able to' do

    it 'create statuses' do
      @lindsey.add_status @status_01
      @lindsey.add_status @status_02

      expect(@lindsey.statuses).to eql [@status_01, @status_02]
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
