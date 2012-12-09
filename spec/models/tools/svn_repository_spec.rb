require 'spec_helper'

describe Tools::SvnRepository do

	let!(:svn_repository) { FactoryGirl.create(:svn_repository) }

	subject { svn_repository }

	it { should respond_to(:title) }
	it { should respond_to(:url) }

	describe "when SVN Repository is created" do

		describe "with no title" do
			before { svn_repository.title = nil }
			it { should_not be_valid }
		end

		describe "with no url" do
			before { svn_repository.url = nil }
			it { should_not be_valid }
		end

		describe "with no valid url" do
			it "should not validate" do
				should_not allow_value('someCoolURL').for(:url)
			end
		end

	end

	describe "when SVN Repo is deleted" do
		it "should destroy SVN Repo" 
	end

	describe "when requesting SVN log" do #log

		it "get an RSCM::Revisions Class back" do
			revisions = svn_repository.log
			revisions.should be_an_instance_of(RSCM::Revisions) 
		end

		describe "with Revision number 850" do
			revisions = nil
			before { revisions = svn_repository.log(850) }

			it "the first Revision is RevisionNr +1" do
				revisions[1].identifier eq(851)
			end

			it "get 10 last revisions back (851-860)" do
				# currently, Rev860 is the last
				revisions.length.should eq(10)
			end
		end

		describe "with UTC" do #Universal Time Coordinated
		end

	end

	describe "when creating an SVN repository" do

		describe "and svn username only" do
			it "should not validate the svn username" do
				pending
				#FactoryGirl.create(:svn_repository, svn_username: "robem").should_not be_valid
			end
		end

		describe "and svn password only" do
			it "should not validate the svn password" do
				pending
				#FactoryGirl.create(:svn_repository, svn_password: "secret").should_not be_valid
			end
		end

		describe "and svn password and username are given" do
			it "should be valid" do
				FactoryGirl.create(:svn_repository, svn_username: "robem",svn_password: "secret").should be_valid
			end
		end

	end

end
