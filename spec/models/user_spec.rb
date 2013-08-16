require_relative '../spec_helper'

describe 'User' do

  let(:john){ Fabricate :john }
  let( :bob){ Fabricate  :bob }

  let(:status){ Fabricate :status }

  describe 'should be able to' do

    it 'create a status' do
      john.add_status status

      expect(john.statuses).to eql [status]
    end

    it 'follow other users' do
      john.add_followee bob

      expect(john.followees).to eql [bob]
      expect(john.followers).to be_empty
    end

    it 'know the users who follow him/her' do
      puts john.methods
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
