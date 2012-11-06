require 'spec_helper'

describe "API v1 Users" , :type => :request do


  let(:user) { FactoryGirl.create(:user) }

  describe "get authentificated user" do
    let(:user_url) { "/api/v1/user" }
    let(:users_url) { "/api/v1/users" }

    it "with basic_auth returns UserDTO as JSON" do
      get "#{user_url}", nil, basic_auth(user.username)

      user_json = UserDTO.new(user.username, user.email, [], []).to_json
      response.body.should eql(user_json)
      response.status.should eql(200)
    end
  end

  describe "post new user" do

    let(:new_user) { FactoryGirl.build(:user) }

    describe "with valid information" do
      before do
        post "#{users_url}",
          user: { username: new_user.username, email: new_user.email, password: 'foobar', password_confirmation: 'foobar' },
          :format => :json
      end

      it "should respond with 201" do
        response.status.should eql(201)
      end

      it "should return new user" do
        response.body.should include "#{new_user.username}"
        response.body.should include "#{new_user.email}"
        response.body.should_not include 'password'
      end
    end

    describe "with invalid information (email wrong)" do
      before do
        post "#{user_url}",
          user: { username: new_user.username, email: 'failemail.com', password: 'foobar', password_confirmation: 'foobar' },
          :format => :json
      end

      it "should respond with 422" do
        response.status.should eql(422)
      end

      it "should return error message" do
        response.body.should include 'error'
        response.body.should include 'email','invalid'
      end
    end

  end

  describe "updated users email adress" do
    new_email = "test@with_put.com"

    before do
      put "#{user_url}", { email: new_email }, basic_auth(user.username)
    end

    it "should respond with 204" do
      response.status.should eql(204)
    end
  end

  describe "delete user" do
    let(:user_for_delete) { FactoryGirl.create(:user) }
    before do

      delete "#{user_url}", nil, basic_auth(user_for_delete.username)
    end

    it "should respond with 204" do
      response.status.should eql(204)
    end
  end
end
