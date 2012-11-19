require 'spec_helper'

describe "Api::V1::ProjectErrors" do


  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  let!(:project_u1) { FactoryGirl.create(:project, user: user) }

  let(:projects_url) { "/api/v1/projects" }

  describe "Get Error 404 Not found" do
    describe "get single project with invalid id" do
      before do
        get "#{projects_url}/123", nil, basic_auth(user.username)
      end

      it "should return 404" do
        response.status.should eql(404)
      end

      it "response error message" do
        response.body.should include "Couldn't find Project with id="
      end
    end
  end

  describe "Get Error 403 Forbidden" do
    before do
      get "#{projects_url}/#{project_u1.id}", nil, basic_auth(user2.username)
    end
    it "should return 403" do
      response.status.should eql(403)
    end
  end

  describe "Post Error 422 Unprocessable Entity" do
    describe "post project with no title" do
      before do
        post "#{projects_url}", nil, basic_auth(user.username)
      end

      it "should return 422" do
        response.status.should eql(422)
      end

      it "response error message" do
        response.body.should include "title", "blank"
      end
    end
  end

  describe "Delete Error 403 Forbidden" do
    describe "delete project while not owner" do
      before do
        delete "#{projects_url}/#{project_u1.id}", nil, basic_auth(user2.username)
      end

      it "should return 403" do
        response.status.should eql(403)
      end
    end
  end

end
