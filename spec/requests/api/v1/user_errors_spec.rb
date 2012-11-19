require 'spec_helper'

describe "Api::V1::UserErrors" do

  describe "post new user" do

    let(:new_user) { FactoryGirl.build(:user) }

    describe "with invalid information (email wrong)" do
      before do
        post "#{users_url}",
          user: { username: new_user.username, email: 'failemail.com', password: 'foobar', password_confirmation: 'foobar' },
          :format => :json
      end

      it "should respond with 422" do
        response.status.should eql(422)
      end

      it "should return error message" do
        response.body.should include 'email','invalid'
      end
    end
  end

end
