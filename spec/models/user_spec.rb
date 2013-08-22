require_relative '../spec_helper'

describe User do

  before :all do
    @franz   = Fabricate :franz
    @lindsey = Fabricate :lindsey
    @michael = Fabricate :michael

    @status_01 = Fabricate.build :status_01
    @status_02 = Fabricate.build :status_02
    @status_03 = Fabricate.build :status_03
  end

  after :all do
    @franz.destroy
    @lindsey.destroy
    @michael.destroy
  end

  describe 'should be able to' do

    before(:each){
      @lindsey.remove_all_followers
      @franz.remove_all_followers
    }

    it 'create statuses' do
      @lindsey.add_status @status_01
      @lindsey.add_status @status_02

      expect(@lindsey.statuses).to eql [@status_01, @status_02]
    end

    it 'follow other users' do
      @lindsey.follows @franz

      expect(@lindsey.followees).to eql [@franz]
    end

    it 'know the users who follow him/her' do
      @lindsey.follows @franz

      expect(@franz.followers).to eql [@lindsey]
    end

    it 'know the users whom he/she follows' do
      @lindsey.follows @franz

      expect(@lindsey.followees).to eql [@franz]
    end

    it 'get own timeline' do
      @michael.follows @franz

      @status_01.add_recipient @michael
      @lindsey.add_status @status_01

      @franz.add_status @status_02
      @michael.add_status @status_03

      expect(@michael.timeline).to eql [@status_03, @status_02, @status_01]
    end

  end
end
