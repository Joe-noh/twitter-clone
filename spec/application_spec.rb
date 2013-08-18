require_relative './spec_helper'

describe 'User' do

  before(:all){ @lindsey = Fabricate :lindsey }

  after(:all){ @lindsey.destroy }

  context 'Logged out' do

    it "getting '/' should redirect to log in page" do
      get '/'
      follow_redirect!

      expect(last_response.body).to include 'Log in'
    end

    it "posting '/login' with correct params should redirect to the user's home" do
      post '/login', :username => 'LindseyWells', :password => 'mysecret'
      follow_redirect!

      expect(last_response.body).to include 'LindseyWells'
    end

    it "posting '/login' with not-exist-ID should render login page" do
      post '/login', :username => 'Foo', :password => 'Bar'

      expect(last_response.body).to include 'Authentication Failed'
    end

    it "posting '/login' with blank params should render login page with error message" do
      post '/login', :username => 'LindseyWells', :password => ''
      expect(last_response.body).to include 'Authentication Failed'

      post '/login', :username => '', :password => 'mysecret'
      expect(last_response.body).to include 'Authentication Failed'

      post '/login', :username => '', :password => ''
      expect(last_response.body).to include 'Authentication Failed'
    end
  end

  context 'Logged in' do

    before(:each){ login_as @lindsey }

    after(:each){ logout }

    it "getting '/' should render user's home" do
      get '/'

      expect(last_response.body).to include 'LindseyWells'
    end
  end
end
