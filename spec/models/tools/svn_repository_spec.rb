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
			it "should raise an exception" do
				svn_repository_url_fail = FactoryGirl.create(:svn_repository, url: "someCoolURL") 
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
				#revisions = svn_repository.log(850)
				revisions[1].identifier eq(851)
			end
				
			it "get 10 last revisions back (851-860)" do
				# currently, Rev860 is the last
				#revisions = svn_repository.log(850)
				revisions.length.should eq(10)
			end
		end

		describe "with UTC" do #Universal Time Coordinated
		end

		describe "with an svn account" do

			describe "and svn username only" do
				it "should raise an exception" do
					svn_repository.svn_username = "robem"
					expect { svn_repository.log }.should raise_exception(ArgumentError)
				end
			end

			describe "and svn password only" do
				it "should raise an exception"
			end

		end

	end

end
