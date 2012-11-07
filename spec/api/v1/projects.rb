require 'spec_helper'

describe "API v1 Projects" , :type => :request do


  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  let!(:project_u1) { FactoryGirl.create(:project, user: user) }
  let!(:project2_u1) { FactoryGirl.create(:project, user: user) }
  let!(:project_u2) { FactoryGirl.create(:project, user: user2) }

  let(:user_projects_url) { "/api/v1/user/projects" }
  let(:projects_url) { "/api/v1/projects" }

  describe "get user projects" do
    before do
      get "#{user_projects_url}", nil, basic_auth(user.username)
    end

    it "should return 200" do
      response.status.should eql(200)
    end

    it "response should include project_u1" do
      user_projects_json = projects_to_simple_dto(Project.by_user(user)).to_json
      response.body.should eql(user_projects_json)
    end

    it "response should include tilte, desc, due_date and id" do
      response.body.should include ('title')
      response.body.should include (project_u1.title)
      response.body.should include (project2_u1.title)

      response.body.should include ('desc')
      response.body.should include (project_u1.desc)

      response.body.should include ('due_date')
      response.body.should include ('id')
    end
  end

  describe "get single project" do
    before do
      get "#{projects_url}/#{project_u1.id}", nil, basic_auth(user.username)
    end

    it "should return 200" do
      response.status.should eql(200)
    end

    it "response should include project_u1" do
      project_u1_json = ProjectDTO.new(project_u1).to_json
      response.body.should eql(project_u1_json)
    end
  end

  describe "post new project" do
    before do
      post "#{projects_url}", {project: { title: "new project", due_date: Date.tomorrow }}, basic_auth(user.username)
    end

    it "should respond with 201" do
      response.status.should eql(201)
      Project.count.should eql(4)
    end
    it "should respond with new project" do
      response.body.should include "new project"
    end
  end

  describe "updated project" do

    before do
      put "#{projects_url}/#{project2_u1.id}", { desc: "new desc", due_date: Date.tomorrow }, basic_auth(user.username)
    end

    it "should respond with 200" do
      response.status.should eql(200)
      Project.count.should eql(3)
    end
    it "should respond with updated project" do
      response.body.should include "desc"
    end
  end

  describe "delete project" do

    before do
      delete "#{projects_url}/#{project2_u1.id}", nil, basic_auth(user.username)
    end

    it "should respond with 204" do
      response.status.should eql(200)
      Project.count.should eql(2)
    end
    it "should respond with message" do
      response.body.should include 'Project deleted'
    end
  end
end