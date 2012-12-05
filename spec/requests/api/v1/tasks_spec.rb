require 'spec_helper'

describe "Api::V1::Tasks" do
  let(:tasks_url) { "/api/v1/tasks" }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let!(:task1) { FactoryGirl.create(:task, project: project, creator: user) }
  let!(:task2) { FactoryGirl.create(:task, project: project, creator: user) }
  let(:task_id)

  before(:each) do
    @task3 = FactoryGirl.create(:task, project: project, creator: user)
  end
  describe "GET single task by id" do
    before do
      get "#{tasks_url}/#{task1.id}", nil, basic_auth(user.username)
    end
    subject { response }

    it { status.should eql(200) }

    it "returns task as json" do
      task1_json = TaskSerializer.new(task1).to_json
      response.body.should eql(task1_json)
    end
  end

  describe "CREATE single task for project" do
    title = "test from post"
    desc = "my next test task"

    before do
      post "#{tasks_url}", { task: { title: "#{title}", desc: desc, project_id: project.id } }, basic_auth(user.username)
    end

    it "responds with  201" do
      response.status.should eql(201)
    end

    it "returns task as json with project_id and creator_id" do
      response.body.should include(title)
      response.body.should include(desc)
      response_json = JSON.parse(response.body)
      response_json['task']['project_id'].should eql project.id
      response_json['task']['creator_id'].should eql user.id
    end
  end

  describe "PUT task" do
    title = "new title"
    desc = "new desc"

    before do
      put "#{tasks_url}/#{task1.id}", { task: { title: "#{title}", desc: desc, worker_id: user2.id } }, basic_auth(user.username)
    end
    # it { should respond_with_content_type(:json) }

    subject { response }

    it "responds with  201" do
      status.should eql(200)
    end


    it "returns task with new parameters" do
      response.body.should include(title)
      response.body.should include(desc)
      response_json = JSON.parse(response.body)
      response_json['task']['worker_id'].should eql user2.id
    end
  end

  describe "DELETE task" do

    before do
      delete "#{tasks_url}/#{@task3.id}", nil, basic_auth(user.username)
    end

    it "responds with 204" do
      response.status.should eql(204)
    end
  end
end
