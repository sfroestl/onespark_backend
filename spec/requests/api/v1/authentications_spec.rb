require 'spec_helper'

describe "Api::V1::Authentications" do

  let(:user) { FactoryGirl.create(:user) }

  describe "get authentificated user" do
    let(:url) { "/api/v1/user" }

    it "without authentification should return 401" do
      get "#{url}.json"

      response.status.should eql(401)
      response.body.should include ('HTTP Basic: Access denied.')
    end
  end
end
