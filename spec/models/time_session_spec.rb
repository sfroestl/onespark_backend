require 'spec_helper'

describe TimeSession do
  let!(:creator) { FactoryGirl.create(:user) }
  let!(:worker) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: creator) }
  let(:task) { project.tasks.create(title: "new task", creator: creator)}
  let(:time_session) { TimeSession.new }

  subject { time_session }

  it { should respond_to(:start) }
  it { should respond_to(:end) }
  it { should respond_to(:user) }
  it { should respond_to(:task) }


  describe "without start datetime" do
    it "is invalid" do
      new_time_session = task.time_sessions.build( user: worker)
      new_time_session.should_not be_valid
    end
  end

  describe "with wrong start datetime" do
    it "is invalid" do
      new_time_session = task.time_sessions.build(start: "asdasd", user: worker)
      new_time_session.should_not be_valid
    end
  end

  describe "without end datetime" do
    it "is valid" do
      new_time_session = task.time_sessions.build(start: DateTime.now, user: worker)
      new_time_session.should be_valid
    end
  end

  describe "with end time before start time" do
    it "is invalid" do
      new_time_session = task.time_sessions.build(start: DateTime.now, end: 2.days.ago, user: worker)
      new_time_session.should_not be_valid
    end
  end

  describe "with end time after start time" do
    it "is valid" do
      new_time_session = task.time_sessions.build(start: DateTime.now, end: 2.days.from_now, user: worker)
      new_time_session.should be_valid
    end
  end
end
