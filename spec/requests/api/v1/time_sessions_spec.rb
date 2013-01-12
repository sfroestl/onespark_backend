require 'spec_helper'

describe "Api::V1::TimeSessions" do
  let(:time_sessions_url) { "/api/v1/time_sessions" }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let!(:task) { FactoryGirl.create(:task, project: project, creator: user) }
  let!(:time_session) { FactoryGirl.create(:time_session, task: task, user: user, start: DateTime.now)}

  describe "GET single time session by id" do
    before do
      get "#{time_sessions_url}/#{time_session.id}", nil, basic_auth(user.username)
    end
    subject { response }

    it { status.should eql(200) }

    it "returns time_session as json" do
      time_session_json = TimeSessionSerializer.new(time_session).to_json
      response.body.should eql(time_session_json)
    end
  end

  describe "CREATE time session for task" do
    start_date = DateTime.now
    before do
      post "#{time_sessions_url}", { time_session: { task_id: task.id, start: start_date } }, basic_auth(user.username)
    end
    it "responds with  201" do
      response.status.should eql(201)
    end

    it "returns time_session as json with task_id" do
      response_json = JSON.parse(response.body)
      response_json['time_session']['task_id'].should eql task.id
    end
    it "returns time_session as json with start" do
      response_json = JSON.parse(response.body)
      response_start_time = response_json['time_session']['start'].to_json
      response_start_time.should eql start_date.to_json
    end
    it "returns time_session as json with user_id" do
      response_json = JSON.parse(response.body)
      response_json['time_session']['user_id'].should eql user.id
    end
  end

  describe "PUT update end time on time_session" do
    end_time = 1.day.from_now
    before do
      put "#{time_sessions_url}/#{time_session.id}", { time_session: { end: end_time } }, basic_auth(user.username)
    end

    it "responds with  200" do
      status.should eql(200)
    end

    it "returns time_session with new parameter" do
      response_json = JSON.parse(response.body)
      response_end_time = response_json['time_session']['end'].to_json
      response_end_time.should eql end_time.to_json
    end
  end

  describe "DELETE time_session" do
    before do
      @time_session1 = FactoryGirl.create(:time_session, task: task, user: user, start: DateTime.now)
      delete "#{time_sessions_url}/#{@time_session1.id}", nil, basic_auth(user.username)
    end

    it "responds with 204" do
      response.status.should eql(204)
    end
  end
end
