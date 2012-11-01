require 'spec_helper'

describe "API v1 Users" , :type => :request do


  let(:user) { FactoryGirl.create(:user) }

  describe "get authentificated user" do
    let(:url) { "/api/v1/user" }

    it "with basic_auth returns UserDTO as JSON" do
      get "#{url}", nil, basic_auth(user.username)

      user_json = UserDTO.new(user.username, user.email, [], []).to_json
      response.body.should eql(user_json)
      response.status.should eql(200)
    end
  end

  describe "post new user" do
    let(:url) { "/api/v1/users" }
    let(:new_user) { FactoryGirl.build(:user) }

    before do
      post "#{url}",
      user: { username: new_user.username, email: new_user.email, password: 'foobar', password_confirmation: 'foobar' },
      :format => :json
    end

    it "should respond with 201" do
      response.status.should eql(201)
    end

    it "should return new user" do
      response.body.should include "#{new_user.username}"
      response.body.should include "#{new_user.email}"
    end

  end

  describe "put updated user" do
    let(:url) { "/api/v1/user" }

    before do
      put "#{url}", {email: "test@with_put.com"}, basic_auth(user.username)
    end

    it "should respond with 204" do
      response.status.should eql(204)
    end
  end

  describe "delete user" do
    let(:url) { "/api/v1/user" }
    let(:user_for_delete) { FactoryGirl.create(:user) }
    before do

      delete "#{url}", nil, basic_auth(user_for_delete.username)
    end

    it "should respond with 204" do
      print response.body
      response.status.should eql(204)
    end
  end
end
