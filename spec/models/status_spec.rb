require_relative '../spec_helper'

describe Status do

  before(:all){
    @franz   = Fabricate :franz
    @lindsey = Fabricate :lindsey
    @michael = Fabricate :michael

    @status  = Fabricate.build :status_01
  }

  after(:all){
    @franz.destroy
    @lindsey.destroy
    @michael.destroy
  }

  it 'should specify recipients' do
    @franz.add_status @status
    @status.add_recipient @lindsey
    @status.add_recipient @michael

    expect(@status.recipients).to eql [@lindsey, @michael]
  end
end